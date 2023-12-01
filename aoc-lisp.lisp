;;;; aoc-lisp.lisp

(in-package #:aoc-lisp)

(defun hello()
  (print "test Vest"))

(defun show-input (day)
  (let ((sum 0))
    (let* ((fileName (format nil "input~2,'0d.txt" day))
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream nil)
        while line
        do (let ((num (get-number line)))
             (setq sum (+ sum num))))
      (close fileStream))
    (print sum)
    )
  )

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
