(ns aoc.6-2
  (:require [clojure.string :as string])
  (:require [clojure.set :as set])
  (:require [aoc.utils :as utils]))

(def day 6)
(def input (string/split (utils/input day) #"\n\n"))

(defn count-group [answers]
  (->> answers
      (string/split-lines)
      (map #(set %))
      (reduce set/intersection)
      (count)))

(defn run []
  (->> input
       (map count-group)
       (flatten)
       (reduce +)))

