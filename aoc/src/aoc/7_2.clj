(ns aoc.7-2
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

(def day 7)
(def input (string/split-lines (utils/input day)))

(defn nested-bag-list [[count adj color]]
  (repeat (Integer/parseInt count) (str adj color)))

(defn parse-line
  "Return a map of the bag to its contents:
   {wavyindigo [clearturquoise clearturquoise clearturquoise drabbronze]}"
  [line]
  (let [[bag contents] (string/split line #" contain ")
        [adj color] (subvec (string/split bag #" ") 0 2)]

    {(str adj color) (->> (string/split contents #", ")
                          (map #(string/split % #" "))
                          (filter #(>= (count %) 4))
                          (mapcat nested-bag-list))}))

(defn expand-contents [bags contents]
  (loop [remaining contents expanded-contents []]
    (if (empty? remaining)
      expanded-contents
      (let [head (first remaining)
            expanded (concat remaining (get bags head))]
        (recur (rest expanded)
               (conj expanded-contents head))))))

(defn run []
  (let [bags (into {} (map parse-line input))
        my-bag (bags "shinygold")
        my-bag-contents (expand-contents bags my-bag)]
    (count my-bag-contents)))

