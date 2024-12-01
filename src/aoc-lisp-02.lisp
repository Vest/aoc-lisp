;;;; aoc-lisp-02.lisp

(defpackage :aoc-lisp/day02
  (:use :cl)
  (:export #:show-answers))

(in-package :aoc-lisp/day02)

(defun show-answers()
  (let ((part-a (show-part-a))
        (part-b (show-part-b)))
    (print (format t "Day02: ~a, ~a~%" part-a part-b))))

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
        do (let* ((least-dice (get-least-dice line))
                 (calc-dice (calculate-dice least-dice)))
             (setq sum (+ sum calc-dice))))
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
         (dice-str (split-line game))
         (dice (mapcar #'(lambda (x) (split-token x)) dice-str))
         (first-invalid (find-if-not #'is-enough dice)))
        (if first-invalid 0 game-number)))

(defstruct dice
  red
  green
  blue)


(defun map-dice (dice)
  (let ((a (first dice))
        (c (second dice))
        (d (make-dice :red 0 :green 0 :blue 0)))
    (cond ((string= c "red") (setf (dice-red d) a))
          ((string= c "green") (setf (dice-green d) a))
          ((string= c "blue") (setf (dice-blue d) a)))
        d
    ))


(defun get-least-dice (game)
  (let* ((dice-str (split-line game))
         (dice (mapcar #'(lambda (x) (map-dice (split-token x))) dice-str))
         (least-dice (reduce #'(lambda (a d)
                                 (let ((max-red   (max (dice-red   d) (dice-red   a)))
                                       (max-green (max (dice-green d) (dice-green a)))
                                       (max-blue  (max (dice-blue  d) (dice-blue  a))))
                                  (make-dice :red max-red :green max-green :blue max-blue)
                                 )) dice :initial-value (make-dice :red 0 :green 0 :blue 0))) )
    least-dice))

(defun calculate-dice (dice)
  (* (dice-red dice) (dice-green dice) (dice-blue dice)))
