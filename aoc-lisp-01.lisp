(defpackage :aoc-lisp/day01
  (:use :cl)
  (:export #:show-answers))

(in-package :aoc-lisp/day01)

(defun show-answers()
  (let ((part-a (show-part-a))
        (part-b (show-part-b)))
    (print (format t "Day01: ~a, ~a~%" part-a part-b))))

(defun show-part-a ()
  (let ((sum 0))
    (let* ((fileName "input01.txt")
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream nil)
        while line
        do (let ((num (get-number line)))
             (setq sum (+ sum num))))
      (close fileStream))
    sum))

(defun show-part-b ()
  (let ((sum 0))
    (let* ((fileName "input01.txt")
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream nil)
        while line
        do (let ((num (get-better-number line)))
             (setq sum (+ sum num))))
      (close fileStream))
    sum))

(defun get-left-number (str)
  (loop
    for c across str thereis (digit-char-p c)))

(defun get-right-number (str)
  (loop
    for c across (reverse str) thereis (digit-char-p c)))

(defun get-number (str)
  (let* ((left (get-left-number str))
        (right (get-right-number str)))
    (+ (* left 10) right)))

(defun get-left-match (str)
   (ppcre:scan-to-strings "(one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9)" str))


(defun get-right-match (str)
   (reverse (ppcre:scan-to-strings (reverse ")one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9(") (reverse str))))

(defun get-better-number (str)
  (let* ((leftStr (get-left-match str))
        (rightStr (get-right-match str))
        (left (convert-string-to-digit leftStr))
        (right (convert-string-to-digit rightStr)))
    (+ (* left 10) right)))

(defun convert-string-to-digit (str)
   (cond ((string= str "one") '1)
        ((string= str "two") '2)
        ((string= str "three") '3)
        ((string= str "four") '4)
        ((string= str "five") '5)
        ((string= str "six") '6)
        ((string= str "seven") '7)
        ((string= str "eight") '8)
        ((string= str "nine") '9)
        ((string= str "1") '1)
        ((string= str "2") '2)
        ((string= str "3") '3)
        ((string= str "4") '4)
        ((string= str "5") '5)
        ((string= str "6") '6)
        ((string= str "7") '7)
        ((string= str "8") '8)
        ((string= str "9") '9)
        ))
