(ns aoc.6-1
  (:require [clojure.string :as string])
  (:require [aoc.utils :as utils]))

(def day 6)
(def input (string/split (utils/input day) #"\n\n"))

(defn count-group [answers]
  (-> answers
      (string/split-lines)
      (string/join)
      (set)
      (count)))

(defn run []
  (->> input
       (map count-group)
       (reduce +)))

