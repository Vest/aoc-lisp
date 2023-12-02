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

(test get-left-match-test
  (is (string= "6" (aoc-lisp::get-left-match "gkqzprfcrfcgpxnvggsnccsrrk64oneseven")))
  (is (string= "six" (aoc-lisp::get-left-match "six36fnqmdcjgjgbqgqcgffivetskhjhkpdqfive"))))

(test get-right-match-test
  (is (string= "seven" (aoc-lisp::get-right-match "gkqzprfcrfcgpxnvggsnccsrrk64oneseven")))
  (is (string= "five" (aoc-lisp::get-right-match "six36fnqmdcjgjgbqgqcgffivetskhjhkpdqfive"))))

(test convert-string-to-digit-test
  (is (= 2 (aoc-lisp::convert-string-to-digit "two")))
  (is (= 8 (aoc-lisp::convert-string-to-digit "eight")))
  (is (= 8 (aoc-lisp::convert-string-to-digit "8")))
  (is (= 2 (aoc-lisp::convert-string-to-digit "2"))))

(test get-better-number-test
  (is (= 29 (aoc-lisp::get-better-number "two1nine")))
  (is (= 76 (aoc-lisp::get-better-number "7pqrstsixteen"))))

(test split-line-test
  (is (equal '("3 blue" "4 red" "1 red" "2 green" "6 blue" "2 green")
             (aoc-lisp::split-line-02 "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"))))

(test split-game-test
  (is (= 2 (aoc-lisp::split-game-02 "Game 2: 3 blue"))))

(test split-token-test
  (is (equal '(3 "blue")
             (aoc-lisp::split-token-02 "3 blue"))))

(test is-enough-test
   (is (aoc-lisp::is-enough '(3 "red")))
   (is (not (aoc-lisp::is-enough '(20 "red")))))

(test is-game-valid-test
  (is (= 1 (aoc-lisp::is-game-valid "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")))
  (is (= 0 (aoc-lisp::is-game-valid "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"))))
