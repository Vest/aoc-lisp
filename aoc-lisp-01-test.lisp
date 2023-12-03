(in-package :cl-user)

(defpackage :aoc-lisp/test
  (:use :cl
        :aoc-lisp
        :fiveam))

(in-package :aoc-lisp/test)

(def-suite aoc-day1
  :description "Day 1 suite for AoC tests")

(in-suite aoc-day1)

(test get-left-number-test
  (is (= 3 (aoc-lisp/day01::get-left-number "pqr3stu8vwx"))))

(test get-right-number-test
  (is (= 8 (aoc-lisp/day01::get-right-number "pqr3stu8vwx"))))

(test get-number-test
  (is (= 38 (aoc-lisp/day01::get-number "pqr3stu8vwx")))
  (is (= 77 (aoc-lisp/day01::get-number "treb7uchet"))))

(test get-left-match-test
  (is (string= "6" (aoc-lisp/day01::get-left-match "gkqzprfcrfcgpxnvggsnccsrrk64oneseven")))
  (is (string= "six" (aoc-lisp/day01::get-left-match "six36fnqmdcjgjgbqgqcgffivetskhjhkpdqfive"))))

(test get-right-match-test
  (is (string= "seven" (aoc-lisp/day01::get-right-match "gkqzprfcrfcgpxnvggsnccsrrk64oneseven")))
  (is (string= "five" (aoc-lisp/day01::get-right-match "six36fnqmdcjgjgbqgqcgffivetskhjhkpdqfive"))))

(test convert-string-to-digit-test
  (is (= 2 (aoc-lisp/day01::convert-string-to-digit "two")))
  (is (= 8 (aoc-lisp/day01::convert-string-to-digit "eight")))
  (is (= 8 (aoc-lisp/day01::convert-string-to-digit "8")))
  (is (= 2 (aoc-lisp/day01::convert-string-to-digit "2"))))

(test get-better-number-test
  (is (= 29 (aoc-lisp/day01::get-better-number "two1nine")))
  (is (= 76 (aoc-lisp/day01::get-better-number "7pqrstsixteen"))))
