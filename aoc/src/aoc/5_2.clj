(ns aoc.5-2
  (:require [aoc.5-1 :as part-1]))

(defn run []
  (->> part-1/seats
       (sort)
       (partition 2 1)
       (filter (fn [[a b]] (if (< 1 (- b a)) true)))
       (first)
       (first)
       (inc)))
