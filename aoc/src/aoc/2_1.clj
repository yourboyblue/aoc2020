(ns aoc.2-1
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

(defn pw-parts [s]
  (let [[constraint, pw] (string/split s #":\s")
        [range, letter] (string/split constraint #"\s")
        [min, max] (string/split range #"-")]

    {:min (Integer/parseInt min)
     :max (Integer/parseInt max)
     :letter letter
     :pw pw}))

(defn pw-valid? [{:keys [min max letter pw]}]
  (let [letter-count (or ((frequencies pw) (.charAt letter 0)) 0)]
    (<= min letter-count max)))

(defn run [] 
  (count (filterv pw-valid? (map pw-parts (string/split-lines (utils/input 2))))))
