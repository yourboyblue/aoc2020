(ns aoc.5-1
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

(defn to-bin [letter]
  (case letter
    \B \1
    \R \1
    \0))
  
(defn to-int [code]
  (Integer/parseInt (string/join (map to-bin code)) 2))

(defn to-seat-id [code]
  (let [row (to-int (subs code 0 7))
        col (to-int (subs code 7))]
    (+ col (* 8 row))))

(def day 5)
(def input (string/split-lines (utils/input day)))
(def seats (map to-seat-id input))

(defn run []
  (apply max seats))
   
