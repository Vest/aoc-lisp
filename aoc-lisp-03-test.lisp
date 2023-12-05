(in-package :cl-user)

(defpackage :aoc-lisp/test
  (:use :cl
        :aoc-lisp
        :fiveam))

(in-package :aoc-lisp/test)


(def-suite aoc-day2
  :description "Day 1 suite for AoC tests")

(in-suite aoc-day2)

(test make-field
  (is (equal '("3 blue" "4 red" "1 red" "2 green" "6 blue" "2 green")
             (aoc-lisp/day02::split-line "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"))))
