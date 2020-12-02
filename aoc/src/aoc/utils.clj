(ns aoc.utils
  (:require [clojure.string :as string])
  (:require [clojure.java.io :as io])
  (:require [clj-http.client :as client]))

(def cookie (string/trim (slurp ".cookie")))
(defn- input-url [day] (str "https://adventofcode.com/2020/day/" day "/input"))
(defn- input-res [day] (client/get (input-url day) {:headers {:cookie cookie}}))
(defn- input-file [day] (str "input/" day ".txt"))
(defn- fetch-input [day] (spit (input-file day) ((input-res day) :body)))
(defn- input-downloaded? [day] (.exists (io/file (input-file day))))

(defn input [day]
  (or (input-downloaded? day) (fetch-input day))
  (slurp (input-file day)))
