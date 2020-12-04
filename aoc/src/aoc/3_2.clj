(ns aoc.3-2
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

(def day 3)
(def slopes [[1 1] [3 1] [5 1] [7 1] [1 2]])
(def rows (string/split-lines (utils/input day)))

(defn rows-at-slope [y]
  (keep-indexed
   (fn [i row] (if (= 0 (mod i y)) row))
   rows))

(defn tree? [row pos]
  (= (nth (cycle row) pos) \#))

(defn count-trees [slope]
  (let [[x y] slope]
    (count 
     (keep-indexed 
      (fn [i row] (if (tree? row (* x i)) true)) 
      (rows-at-slope y)))))

(defn run []
  (reduce * (map #(count-trees %) slopes)))
