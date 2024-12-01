(defpackage #:aoc-lisp/2024/day01
  (:use :cl)
  (:local-nicknames (#:u :uiop)
                    (#:s :str))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:show-answers))

(in-package #:aoc-lisp/2024/day01)

(defun show-answers()
  (let ((part-a (show-part-a))
        (part-b (show-part-b)))
    (print (format t "Day01: ~a, ~a~%" part-a part-b))))

(defun show-part-a ()
  (let* ((fileName "input/1.txt")
         (fileStream (open fileName))
         (lc ())
         (rc ()))
    (loop
        for line = (read-line fileStream nil)
        while line
        do (let* ((w (s:words line))
                 (l (parse-integer (first w)))
                 (r (parse-integer (second w))))
             (setq lc (append lc (list l)))
             (setq rc (append rc (list r)))
            ))
      (close fileStream)
    (setq lc (sort lc #'(lambda (x y) (< x y))))
    (setq rc (sort rc #'(lambda (x y) (< x y))))
    (apply '+ (mapcar #'(lambda (l r) (abs (- r l))) lc rc))))

(defun show-part-b ()
  (let* ((fileName "input/1.txt")
         (fileStream (open fileName))
         (lc ())
         (rc ()))
    (loop
      for line = (read-line fileStream nil)
      while line
      do (let* ((w (s:words line))
                (l (parse-integer (first w)))
                (r (parse-integer (second w))))
           (setq lc (append lc (list l)))
           (setq rc (append rc (list r)))
           ))
      (close fileStream)
    (reduce #'+
            (mapcar
             #'(lambda (x) (* x (length (remove-if-not #'(lambda (y) (= y x)) rc))))
             lc))))
