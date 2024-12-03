(defpackage #:aoc-lisp/2024/day03
  (:use :cl)
  (:local-nicknames (#:u :uiop)
                    (#:s :str)
                    (#:r :cl-ppcre)
                    (#:a :alexandria))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:show-answers))

(in-package #:aoc-lisp/2024/day03)

(defparameter *test-first* "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
(defparameter *test-second* "do()xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))don't()")

(defun show-answers()
  (let ((part-a (show-part-a))
        (part-b (show-part-b)))
    (print (format t "Day03: ~a, ~a~%" part-a part-b))))

(defun show-part-a ()
  (let* ((fileName "input/3.txt")
         (fileStream (open fileName))
         (tmp ()))
    (loop
        for line = (read-line fileStream nil)
        while line
        do (setq tmp (append tmp (list (calculate-mults line)))))
      (close fileStream)
    (apply #'+ tmp)))

(defun show-part-b ()
  (let* ((fileName "input/3.txt")
         (fileStream (open fileName))
         (input ""))
    (loop
        for line = (read-line fileStream nil)
        while line
        do (setq input (s:concat input line)))
      (close fileStream)
    (let* ((new-input (s:concat "do()" input "don't()"))
                  (with-do (evaluate-with-do new-input))
                  (mults (mapcar #'extract-mults with-do))
                  (calcs (mapcar #'calculate-mult (a:flatten mults))))
      (apply #'+ calcs))))

(defun extract-mults (input)
  (r:all-matches-as-strings "(mul\\(\\d*,\\d*\\))" input))

(defun calculate-mult (input)
  "Executes the expression mul(123,456)"
  (let* ((raw (r:all-matches-as-strings "\\d*" input))
         (str-values-only (remove-if #'s:emptyp raw))
         (values-only (mapcar #'parse-integer str-values-only)))
    (apply #'* values-only)))

(defun calculate-mults (input)
  (let* ((mults (extract-mults input))
         (results (mapcar #'calculate-mult mults)))
    (apply #'+ results)))

(defun evaluate-with-do (input)
  (r:all-matches-as-strings "(?<=do\\(\\))(.*?)(?=don't\\(\\))" input))
