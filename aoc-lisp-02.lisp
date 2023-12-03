;;;; aoc-lisp.lisp

(defpackage :aoc-lisp/day02
  (:use :cl))

(in-package :aoc-lisp/day02)

(defun show-part-a ()
  (let ((sum 0))
    (let* ((fileName "input02.txt")
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream nil)
        while line
        do (let ((game (is-game-valid line)))
             (setq sum (+ sum game))))
      (close fileStream))
    sum))

(defun show-part-b ()
  (let ((sum 0))
    (let* ((fileName "input02.txt")
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream nil)
        while line
        do (let ((game (is-game-valid line)))
             (setq sum (+ sum game))))
      (close fileStream))
    sum))


(defun split-line (str)
  (cdr (ppcre:split "((: )|(, )|(; ))" str)))


(defun split-game (str)
  (parse-integer (second (ppcre:split "(( )|(: ))" str))))


(defun split-token (str)
  (let* ((result (ppcre:split " " str))
         (amount (parse-integer (first result)))
         (color (second result)))
    (list amount color)))

(defun is-enough (dice)
  (let ((a (first dice))
        (c (second dice)))
    (cond ((and (<= a 12) (string= c "red")) t)
          ((and (<= a 13) (string= c "green")) t)
          ((and (<= a 14) (string= c "blue")) t))))

(defun is-game-valid (game)
  (let* ((game-number (split-game game))
         (dices-str (split-line game))
         (dices (mapcar #'(lambda (x) (split-token x)) dices-str))
         (first-invalid (find-if-not #'is-enough dices)))
        (if first-invalid 0 game-number)))
