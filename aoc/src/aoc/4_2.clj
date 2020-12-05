(ns aoc.4-2
  (:require [clojure.string :as string])
  (:require [clojure.set :as set])
  (:require [aoc.utils :as utils]))

(def day 4)
(def input (string/split (utils/input day) #"\n\n"))

(def req-keys (set ["byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid"]))
(def eye-colors (set ["amb" "blu" "brn" "gry" "grn" "hzl" "oth"]))

(defn to-int [n] (Integer/parseInt n))

(defn pair-valid? [[key val]]
  (case key
    "cid" true
    "byr" (<= 1920 (to-int val) 2002)
    "iyr" (<= 2010 (to-int val) 2020)
    "eyr" (<= 2020 (to-int val) 2030)
    "hcl" (re-find #"^#[0-9a-f]{6}$" val)
    "pid" (re-find #"^[0-9]{9}$" val)
    "ecl" (contains? eye-colors val)
    "hgt" (let [[_m num units] (re-find #"^(\d+)(in|cm)$" val)]
            (case units
              "cm" (<= 150 (to-int num) 193)
              "in" (<= 59 (to-int num) 76)
              false))))

(defn pp-pairs [pp-str]
  (map #(string/split % #":") (string/split pp-str #"(\s|\n)")))

(defn pp-keys [pp-str]
  (->> (pp-pairs pp-str)
       (map first)
       (set)))

(defn run []
  (let [pps-to-check (filter #(set/subset? req-keys (pp-keys %)) input)]
    (->> pps-to-check
         (map pp-pairs)
         (filter #(every? pair-valid? %))
         (count))))

