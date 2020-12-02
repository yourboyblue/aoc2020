(ns aoc.1-1
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

;; process input to sorted list of integers
(defn to-int [n] (Integer/parseInt n))
(defn process-input [input] (map to-int (string/split (string/trim input) #"\n")))

(def input (process-input (utils/input 1)))

(defn find-pair [numbers]
  (first
   (for [a numbers
         b numbers
         :when (= 2020 (+ a b))]
     [a, b])))

(defn run []
  (let [[a b] (find-pair input)]
    (* a b) )
  )
