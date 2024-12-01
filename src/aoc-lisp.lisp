;;;; aoc-lisp.lisp

(in-package #:aoc-lisp)

(defun show-answers (day)
  (cond ((= day 01) (aoc-lisp/day01::show-answers))
        ((= day 02) (aoc-lisp/day02::show-answers))
  ))

(aoc-lisp/downloader:download-input "1")
