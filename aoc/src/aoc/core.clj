(ns aoc.core
  (:gen-class)
  (:require [clojure.string :as string])
  (:require [aoc.7-2 :as day-7-part-2])
  (:require [aoc.7-1 :as day-7-part-1])
  (:require [aoc.6-2 :as day-6-part-2])
  (:require [aoc.6-1 :as day-6-part-1])
  (:require [aoc.5-2 :as day-5-part-2])
  (:require [aoc.5-1 :as day-5-part-1])
  (:require [aoc.4-2 :as day-4-part-2])
  (:require [aoc.4-1 :as day-4-part-1])
  (:require [aoc.3-2 :as day-3-part-2])
  (:require [aoc.3-1 :as day-3-part-1])
  (:require [aoc.2-2 :as day-2-part-2])
  (:require [aoc.2-1 :as day-2-part-1])
  (:require [aoc.1-2 :as day-1-part-2])
  (:require [aoc.1-1 :as day-1-part-1]))

(defn -main
  "Run the code for the day/part"
  [day part]
  (apply (resolve (symbol (string/join "-" ["day" day "part" part]) "run")), []))
