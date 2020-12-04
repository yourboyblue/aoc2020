(ns aoc.utils
  (:require [clojure.string :as string])
  (:require [clojure.java.io :as io])
  (:require [clj-http.client :as client]))

(def cookie (string/trim (slurp ".cookie")))
(defn- input-url [day] (str "https://adventofcode.com/2020/day/" day "/input"))
(defn- input-res [day] (client/get (input-url day) {:headers {:cookie cookie}}))
(defn- filename [day] (str "input/" day ".txt"))
(defn- fetch-input [day] (spit (filename day) ((input-res day) :body)))
(defn- input-downloaded? [day] (.exists (io/file (filename day))))
(defn- ensure-input [day] (or (input-downloaded? day) (fetch-input day)))

(defn input [day]
  (ensure-input day)
  (slurp (filename day)))

(defn input-file [day]
  (ensure-input day)
  (io/reader (filename day)))
