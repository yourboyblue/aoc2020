(ns aoc.7-1
  (:require [clojure.string :as string])
  (:require [clojure.set :as set])
  (:require [aoc.utils :as utils]))

(def day 7)
(def input (string/split-lines (utils/input day)))

(defn to-int [i] (Integer/parseInt i))

(defn bag-key [adj color] (str adj "-" color))

(defn list-from-bag [bag]
  (let [[count adj color] (map string/trim (string/split bag #" "))]
    (case count
      "no" []
      (repeat (to-int count) (bag-key adj color)))))

(defn parse-bag-defns 
  "Return a map with the bag as the key, and a set of bags it can contain as the value
   {wavy-indigo #{wavy-purple clear-turquoise drab-bronze}}"
  [line]
  (let [[key rest] (string/split line #"contain")
        [adj color] (subvec (string/split key #" ") 0 2)
        bag-contents (->> (string/split rest #",")
                          (map string/trim)
                          (map list-from-bag)
                          (flatten))]
    
    {(bag-key adj color) (set bag-contents)}))

(defn expand-contents [bags contents]
  (loop [remaining contents expanded-contents #{}]
    (if (empty? remaining)
      expanded-contents
      (let [head (first remaining)
            expanded (concat remaining (get bags head))]
        (recur (set (rest expanded))
               (conj expanded-contents head))))))

(defn run []
  (let [bags (reduce merge (map parse-bag-defns input))]
    (->> bags
         (vals)
         (map #(expand-contents bags %))
         (filter #(contains? % "shiny-gold"))
         (count))))

