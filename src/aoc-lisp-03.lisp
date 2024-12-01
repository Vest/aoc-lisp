;;;; aoc-lisp-03.lisp

(defpackage :aoc-lisp/day03
  (:use :cl)
  (:export #:show-answers))

(in-package :aoc-lisp/day03)

(defun show-answers()
  (let ((part-a (show-part-a))
        (part-b (show-part-b)))
    (print (format t "Day03: ~a, ~a~%" part-a part-b))))

(defun show-part-a ()
  (let ((sum 0))
    (let* ((fileName "input03.txt")
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream nil)
        while line
        do (let ((game 0))
             (setq sum (+ sum game))))
      (close fileStream))
    sum))


(defun show-part-b ()
  (let ((sum 0))
    (let* ((fileName "input03.txt")
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream)
        while line
        do (let ((game 0))
             (setq sum (+ sum game))))
      (close fileStream)
    sum)))

(defun make-field (path size)
  (let ((field (make-array (list size size) :initial-element #\.)))
    (let* ((fileName path)
           (fileStream (open fileName))
           (row 0))
      (loop for line = (read-line fileStream nil)
            while (and (< row size) line)
            do (progn
                 (loop for col from 0 below (min size (length line))
                       do (setf (aref field row col) (char line col)))
                 (incf row)))
      (close fileStream))
    field))

(defun search-left (field row col)
  (if (digit-char-p (aref field row (+ col 1)))
      0
      (let* ((num 0)
             (continue t))
        (loop
          for i downfrom col to 0
              while (eq continue t)
              do (let ((digit (digit-char-p (aref field row i))))
                   (if (print digit)
                      (incf num (* digit (expt 10 (- col i))))
                      (setf continue nil))
                   ))
        num)))

(defun get-char-safe (field row col)
  (let* ((size (array-dimension field 0)))
    (cond ((< row 0) nil)
          ((< col 0) nil)
          ((>= row size) nil)
          ((>= col size) nil)
          (t (aref field row col)))))
