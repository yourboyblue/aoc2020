(ns aoc.core
  (:gen-class)
  (:require [clojure.string :as string])
  (:require [aoc.1-1 :as day-1-part-1]))

(defn -main
  "Run the code for the day/part"
  [day part]
  (apply (resolve (symbol (string/join "-" ["day" day "part" part]) "run")), []))
