(ns aoc.3-1
  (:require [aoc.utils :as utils]))

(def day 3)

(defn tree? [row pos]
  (= (nth (cycle row) pos) \#))

(defn run [] 
  (with-open [rdr (utils/input-file day)]
    (count
      (keep-indexed
       (fn [i row] (if (tree? row (* 3 i)) true))
       (line-seq rdr)))))
