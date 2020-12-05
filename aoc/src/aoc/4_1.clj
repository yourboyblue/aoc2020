(ns aoc.4-1
  (:require [clojure.string :as string])
  (:require [clojure.set :as set])
  (:require [aoc.utils :as utils]))

(def day 4)
(def req-keys (set ["byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid"]))
(def input (string/split (utils/input day) #"\n\n"))

(defn pp-keys [pp-str]
  (set (map first (map #(string/split % #":") (string/split pp-str #"(\s|\n)")))))

(defn run []
  (count (filter #(set/subset? req-keys (pp-keys %)) input)))
