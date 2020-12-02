(ns aoc.core
  (:gen-class)
  (:require [clojure.string :as string])
  (:require [clojure.java.io :as io])
  (:require [clj-http.client :as client])
  (:require [aoc.1-1 :as day-1-part-1]))


(def cookie (string/trim (slurp ".cookie")))
(defn input-url [day] (str "https://adventofcode.com/2020/day/" day "/input"))
(defn input-res [day] (client/get (input-url day) {:headers {:cookie cookie}}))
(defn input-file [day] (str "input/" day ".txt"))
(defn write-input [day] (spit (input-file day) ((input-res day) :body)))
(defn input-downloaded? [day] (.exists (io/file (input-file day))))
(defn input [day]
  (or (input-downloaded? day) (write-input day))
  (slurp (input-file day)))

(defn -main
  "Run the code for the day/part"
  [day part]
  (apply (resolve (symbol (string/join "-" ["day" day "part" part]) "run")), [(input day)]))
