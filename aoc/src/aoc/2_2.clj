(ns aoc.2-2
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

(def input (utils/input 2))

(defn pw-parts [s]
  (let [[constraint, pw] (string/split s #":\s")
        [range, letter] (string/split constraint #"\s")
        [idx1, idx2] (string/split range #"-")]

    {:idx1 (dec (Integer/parseInt idx1))
     :idx2 (dec (Integer/parseInt idx2))
     :letter letter
     :pw pw}))

(defn letter-at [idx word]
  (try (.charAt word idx)
       (catch StringIndexOutOfBoundsException _e) 
       (finally " "))) ;; placeholder non-matching char

(defn pw-valid? [{:keys [idx1 idx2 letter pw]}]
  (let [test-letters (map #(letter-at % pw) [idx1, idx2])
        key (.charAt letter 0)]
    
  (= 1 ((frequencies test-letters) key))))

(defn run []
  (->> input
       string/split-lines
       (map pw-parts)
       (filterv pw-valid?)
       (count)))
