(in-package :cl-user)

(defpackage :aoc-lisp/test
  (:use :cl
        :aoc-lisp
        :fiveam))

(in-package :aoc-lisp/test)

(def-suite aoc-suite
  :description "Top level suite for AoC tests")

(def-suite* day1-a :in aoc-suite
  :description "Day 1, part A test")

(in-suite day1-a)

(test hello-test
    (is (= 5 (+ 3 2))))

(test get-left-number-test
  (is (= 3 (aoc-lisp::get-left-number "pqr3stu8vwx"))))

(test get-right-number-test
  (is (= 8 (aoc-lisp::get-right-number "pqr3stu8vwx"))))

(test get-number-test
  (is (= 38 (aoc-lisp::get-number "pqr3stu8vwx")))
  (is (= 77 (aoc-lisp::get-number "treb7uchet"))))
