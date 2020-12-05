(ns aoc.4-2
  (:require [clojure.string :as string])
  (:require [clojure.set :as set])
  (:require [aoc.utils :as utils]))

(def day 4)
(def input (string/split (utils/input day) #"\n\n"))

(def req-keys (set ["byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid"]))
(def eye-colors (set ["amb" "blu" "brn" "gry" "grn" "hzl" "oth"]))

(defn to-int [n] (Integer/parseInt n))

(defn cid [_v]  (= 1 1))
(defn byr [val] (<= 1920 (to-int val) 2002))
(defn iyr [val] (<= 2010 (to-int val) 2020))
(defn eyr [val] (<= 2020 (to-int val) 2030))
(defn hcl [val] (re-find #"^#[0-9a-f]{6}$" val))
(defn pid [val] (re-find #"^[0-9]{9}$" val))
(defn ecl [val] (contains? eye-colors val))
(defn hgt [val]
  (let [[_m num measure] (re-find #"^(\d+)(in|cm)$" val)]
    (case measure
      "cm" (<= 150 (to-int num) 193)
      "in" (<= 59 (to-int num) 76)
      false)))

(defn pp-pairs [pp-str]
  (map #(string/split % #":") (string/split pp-str #"(\s|\n)")))

(defn pp-keys [pp-str]
  (->> (pp-pairs pp-str)
       (map first)
       (set)))

(defn valid-pairs?
  "For each pair, call the fn name key with the value"
  [pairs]
  (->> pairs
       (every? (fn [[k v]]
                 (let [fn-sym (resolve (symbol (str "aoc.4-2/" k)))]
                   (apply fn-sym [v]))))))

(defn run []
  (let [pps-with-keys (filter #(set/subset? req-keys (pp-keys %)) input)]
    (count (filter valid-pairs? (map pp-pairs pps-with-keys)))))

