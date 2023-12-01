;;;; aoc-lisp.lisp

(in-package #:aoc-lisp)

(defun hello()
  (print "test Vest"))

(defun show-input (day)
  (let* ((fileName (format nil "input~2,'0d.txt" day))
         (fileStream (open fileName)))
    (loop for line = (read-line fileStream nil)
          while line do (format t "~a~%" line))
    (close fileStream)))
