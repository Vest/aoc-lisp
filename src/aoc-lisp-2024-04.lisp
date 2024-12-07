(defpackage #:aoc-lisp/2024/day04
  (:use :cl)
  (:local-nicknames (#:u :uiop)
                    (#:s :str)
                    (#:a :alexandria)
                    (#:c :cl-ppcre))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:show-answers))

(in-package #:aoc-lisp/2024/day04)

(defparameter *first-test* "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX")

(defparameter *first-test-simple* "....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX")

(defparameter *small-test* "..X...
.SAMX.
.A..A.
XMAS.S
.X....")

(defparameter *mas-test* ".M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........")

(defun show-answers()
  (let ((part-a (show-part-a))
        (part-b (show-part-b)))
    (print (format t "Day04: ~a, ~a~%" part-a part-b))))

(defun show-part-a ()
  (let* ((fileName "input/4.txt")
         (input (u:read-file-string fileName)))
   (let* ((array (parse-string-to-array input)))
      (find-xmas array))))

(defun show-part-b ()
  (let* ((fileName "input/4.txt")
         (input (u:read-file-string fileName)))
   (let* ((array (parse-string-to-array input)))
      (find-mas array))))


(defun parse-line-to-list (input)
  (coerce input 'list))

(defun parse-string-to-array (input)
  (let* ((lines (s:lines input))
         (width (length (first lines)))
         (height (length lines))
         (array (make-array (list height width) :initial-element #\.)))
    (loop for row from 0 below height
          append (loop for col from 0 below width
                       do (let* ((raw-line (nth row lines))
                                 (line (parse-line-to-list raw-line)))
                            (setf (aref array row col) (nth col line)))))
    array))

(defun get-safe (array row col)
  (handler-case
      (aref array row col)
    (sb-int:invalid-array-index-error nil)))

(defun get-word-q (array row col)
  (list (get-safe array row col)
        (get-safe array (- row 1) (- col 1))
        (get-safe array (- row 2) (- col 2))
        (get-safe array (- row 3) (- col 3))))

(defun get-word-w (array row col)
  (list (get-safe array row col)
        (get-safe array (- row 1) (- col 0))
        (get-safe array (- row 2) (- col 0))
        (get-safe array (- row 3) (- col 0))))

(defun get-word-e (array row col)
  (list (get-safe array row col)
        (get-safe array (- row 1) (+ col 1))
        (get-safe array (- row 2) (+ col 2))
        (get-safe array (- row 3) (+ col 3))))

(defun get-word-d (array row col)
  (list (get-safe array row col)
        (get-safe array (- row 0) (+ col 1))
        (get-safe array (- row 0) (+ col 2))
        (get-safe array (- row 0) (+ col 3))))

(defun get-word-c (array row col)
  (list (get-safe array row col)
        (get-safe array (+ row 1) (+ col 1))
        (get-safe array (+ row 2) (+ col 2))
        (get-safe array (+ row 3) (+ col 3))))

(defun get-word-x (array row col)
  (list (get-safe array row col)
        (get-safe array (+ row 1) (- col 0))
        (get-safe array (+ row 2) (- col 0))
        (get-safe array (+ row 3) (- col 0))))

(defun get-word-z (array row col)
  (list (get-safe array row col)
        (get-safe array (+ row 1) (- col 1))
        (get-safe array (+ row 2) (- col 2))
        (get-safe array (+ row 3) (- col 3))))

(defun get-word-a (array row col)
  (list (get-safe array row col)
        (get-safe array (- row 0) (- col 1))
        (get-safe array (- row 0) (- col 2))
        (get-safe array (- row 0) (- col 3))))

(defun get-mas (array row col)
  (let* ((tl (get-safe array (- row 1) (- col 1)))
         (bl (get-safe array (+ row 1) (- col 1)))
         (tr (get-safe array (- row 1) (+ col 1)))
         (br (get-safe array (+ row 1) (+ col 1)))
         (letters (list tl bl tr br)))
    (and (equalp (count #\M letters) 2)
         (equalp (count #\S letters) 2)
         (not (equalp tl br))
         (not (equalp bl tr))
         (equalp #\A (get-safe array row col)))))

(defun find-xmas (array)
  (let* ((answer 0)
         (xmas (parse-line-to-list "XMAS"))
         (width (array-dimension array 1))
         (height (array-dimension array 0)))
    (loop for row from 0 below height
          append (loop for col from 0 below width
                       do (if (equalp #\X (get-safe array row col))
                           (let* ((words (list (get-word-q array row col)
                                              (get-word-w array row col)
                                              (get-word-e array row col)
                                              (get-word-d array row col)
                                              (get-word-c array row col)
                                              (get-word-x array row col)
                                              (get-word-z array row col)
                                              (get-word-a array row col))))
                                (incf answer
                                      (length
                                       (remove-if-not #'(lambda (x) (or (equalp x xmas)
                                                                        (equalp x (reverse xmas))))
                                                      words)))))))
    answer))

(defun find-mas (array)
  (let* ((answer 0)
         (width (array-dimension array 1))
         (height (array-dimension array 0)))
      (loop for row from 0 below height
          append (loop for col from 0 below width
                       do (if (get-mas array row col)
                              (incf answer 1))))
    answer))
