(ns aoc.1-2
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

;; process input to sorted list of integers
(defn to-int [n] (Integer/parseInt n))
(defn process-input [input] (map to-int (string/split (string/trim input) #"\n")))

(def input (process-input (utils/input 1)))

;; this could be more efficient since it doesn't stop when it finds the match
(defn find-three [numbers]
  (first
   (for [a numbers
         b numbers
         c numbers
         :let [sum (reduce + [a b c])]
         :when (= 2020 sum)]
     [a b c])))

(defn run []
  (let [[a b c] (find-three input)]
    (* a b c)))
