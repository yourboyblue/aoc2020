(ns aoc.1-1
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

;; process input to sorted list of integers
(defn to-int [n] (Integer/parseInt n))
(defn process-input [input] (sort (map to-int (string/split (string/trim input) #"\n"))))

(def input (process-input (utils/input 1)))

;; this could be more efficient since it doesn't stop when it finds the pair
(defn find-pair [numbers]
  (first
   (for [a (reverse numbers)
         b numbers
         :let [c (+ a b)]
         :while (>= 2020 c)
         :when (= 2020 c)]
     [a, b])))

(defn run []
  (let [[a b] (find-pair input)]
    (* a b) ))
