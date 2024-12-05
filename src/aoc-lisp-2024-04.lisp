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

(defun parse-line-to-list (input)
  (coerce input 'list))

(defun parse-string-to-array (input)
  (let* ((lines (c:split #\Newline input))
         (size (length (first lines)))
         (array (make-array (list size size) :initial-element #\.)))
    (loop for row from 0 below size
          append (loop for col from 0 below size
                       do (let* ((raw-line (nth row lines))
                                 (line (parse-line-to-list raw-line)))
                            (setf (aref array row col) (nth col line)))))
    array))

(defun get-safe (array row col)
  (handler-case
      (aref array row col)
    (sb-int:invalid-array-index-error nil))

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
        (get-safe array (+ row 1) (- col 1))
        (get-safe array (+ row 2) (- col 2))
        (get-safe array (+ row 3) (- col 3))))


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

(defun find-xmas (array)
  (let* ((answer 0)
         (xmas (parse-line-to-list "XMAS"))
         (size (array-dimension array 0)))
    (loop for row from 0 below size
          append (loop for col from 0 below size
                       do (let* ((words (list (get-word-q array row col)
                                              (get-word-w array row col)
                                              (get-word-e array row col)
                                              (get-word-d array row col)
                                              (get-word-c array row col)
                                              (get-word-x array row col)
                                              (get-word-z array row col)
                                              (get-word-a array row col))))
                                (incf answer
                                      (length
                                       (remove-if-not #'(lambda (x) (equalp x xmas)) words))))))
    answer))
