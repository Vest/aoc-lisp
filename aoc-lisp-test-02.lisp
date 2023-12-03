(in-package :cl-user)

(defpackage :aoc-lisp/test
  (:use :cl
        :aoc-lisp
        :fiveam))

(in-package :aoc-lisp/test)


(def-suite aoc-day2
  :description "Day 1 suite for AoC tests")

(in-suite aoc-day2)

(test split-line-test
  (is (equal '("3 blue" "4 red" "1 red" "2 green" "6 blue" "2 green")
             (aoc-lisp/day02::split-line "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"))))

(test split-game-test
  (is (= 2 (aoc-lisp/day02::split-game "Game 2: 3 blue"))))

(test split-token-test
  (is (equal '(3 "blue")
             (aoc-lisp/day02::split-token "3 blue"))))

(test is-enough-test
   (is (aoc-lisp/day02::is-enough '(3 "red")))
   (is (not (aoc-lisp/day02::is-enough '(20 "red")))))

(test is-game-valid-test
  (is (= 1 (aoc-lisp/day02::is-game-valid "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")))
  (is (= 0 (aoc-lisp/day02::is-game-valid "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"))))

(test map-dice-test
  (is (equalp (aoc-lisp/day02::make-dice :red 1 :green 0 :blue 0) (aoc-lisp/day02::map-dice '(1 "red"))))
  (is (equalp (aoc-lisp/day02::make-dice :red 0 :green 2 :blue 0) (aoc-lisp/day02::map-dice '(2 "green"))))
  (is (equalp (aoc-lisp/day02::make-dice :red 0 :green 0 :blue 3) (aoc-lisp/day02::map-dice '(3 "blue")))))

(test get-least-dice
  (is (equalp (aoc-lisp/day02::make-dice :red 20 :green 13 :blue 6) (aoc-lisp/day02::get-least-dice "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red")))

  )
