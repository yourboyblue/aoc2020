(ns aoc.1-2
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

;; process input to sorted list of integers
(defn to-int [n] (Integer/parseInt n))
(defn process-input [input] (sort (map to-int (string/split (string/trim input) #"\n"))))

(def input (process-input (utils/input 1)))

;; this could be more efficient since it doesn't stop when it finds the match
(defn find-three [numbers]
  (first
   (for [a numbers
         b numbers
         c numbers
         :let [s (reduce + [a b c])]
         :while (>= 2020 s)
         :when (= 2020 s)]
     [a, b, c])))

(defn run []
  (let [[a b c] (find-three input)]
    (* a b c)))
