(in-package :cl-user)

(defpackage :aoc-lisp/test
  (:use :cl
        :aoc-lisp
        :fiveam))

(in-package :aoc-lisp/test)


(def-suite aoc-day3
  :description "Day 3 suite for AoC tests")

(in-suite aoc-day3)

(test make-field
  (let* ((field (aoc-lisp/day03::make-field "input03_test.txt" 3))
         (size (array-dimension field 1))
         (expected (make-array '(3 3) :initial-contents '((#\4 #\6 #\7) (#\. #\. #\.) (#\. #\. #\3)))))
    (is (equal size 3))
    (is (equalp expected field))))
