(ns aoc.2-2
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

(defn pw-parts [s]
  (let [[constraint, pw] (string/split s #":\s")
        [range, letter] (string/split constraint #"\s")
        [idx1, idx2] (string/split range #"-")]

    {:idx1 (dec (Integer/parseInt idx1))
     :idx2 (dec (Integer/parseInt idx2))
     :letter letter
     :pw pw}))

(def null-char (.charAt " " 0))
(defn letter-at-idx [idx word]
  (try (.charAt word idx)
       (catch StringIndexOutOfBoundsException _e) 
       (finally null-char)))

(defn pw-valid? [{:keys [idx1 idx2 letter pw]}]
  (let [test-letters [(letter-at-idx idx1 pw) (letter-at-idx idx2 pw)]]
   (= 1 ((frequencies test-letters) (.charAt letter 0)))))

(defn run []
  (count (filterv pw-valid? (map pw-parts (string/split-lines (utils/input 2))))))
