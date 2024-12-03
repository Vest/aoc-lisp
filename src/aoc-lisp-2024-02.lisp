(defpackage #:aoc-lisp/2024/day02
  (:use :cl)
  (:local-nicknames (#:u :uiop)
                    (#:s :str))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:show-answers))

(in-package #:aoc-lisp/2024/day02)

(defun show-answers()
  (let ((part-a (show-part-a))
        (part-b (show-part-b)))
    (print (format t "Day02: ~a, ~a~%" part-a part-b))))

(defun show-part-a ()
  (let* ((fileName "input/2.txt")
         (fileStream (open fileName))
         (answer 0))
    (loop
        for line = (read-line fileStream nil)
        while line
        do (let* ((w (s:words line))
                  (n (mapcar #'(lambda (s) (parse-integer s)) w))
                  (safe (and (is-safe-1 n) (is-safe-2 n))))
             (cond (safe (incf answer)))))
      (close fileStream)
    answer))

(defun is-safe (l)
  (and (is-safe-1 l) (is-safe-2 l)))

(defun is-safe-1 (l)
  (let* ((ia (copy-list l))
         (id (copy-list l)))
    (setq ia (sort ia #'<))
    (setq id (sort id #'>))
    (or (equal ia l) (equal id l))))

(defun is-safe-2 (l)
  (is-safe-2-rec (rest l) (first l)))

(defun is-safe-2-rec (l old-h)
  (cond ((null l) t)
        (t (let* ((new-h (first l))
                  (new-t (rest l))
                  (dist (abs (- new-h old-h))))
            ;(format t "~a ~a ~%" dist new-h)
             (cond ((and (> dist 0) (< dist 4)) (is-safe-2-rec new-t new-h))
                   (t nil))))))

(defun show-part-b ()
  (let* ((fileName "input/2.txt")
         (fileStream (open fileName))
         (answer 0))
    (loop
        for line = (read-line fileStream nil)
        while line
        do (let* ((w (s:words line))
                  (n (mapcar #'(lambda (s) (parse-integer s)) w))
                  (g (guess n))
                  (s (find t (mapcar #'is-safe g))))
             (cond (s (incf answer)))))
      (close fileStream)
    answer))

 (defun guess (l)
   (loop for i from 0 below (length l)
         collect (remove-nth l i)))

(defun remove-nth (l n)
  (mapcar #'first
   (remove-if #'(lambda (e)
        (= (second e) n))
    (mapcar #'(lambda (e p)
                (list e p))
            l (alexandria:iota (length l))))))
