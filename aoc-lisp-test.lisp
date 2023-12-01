(in-package :cl-user)

(defpackage :aoc-lisp/test
  (:use :cl
        :aoc-lisp
        :fiveam))

(in-package :aoc-lisp/test)

(def-suite aoc-suite
  :description "Top level suite for AoC tests")

(def-suite* hello-suite :in aoc-suite)

(test my-test
      (is (= 5 (+ 3 2))))
