;;;; package.lisp

(defpackage #:aoc-lisp
  (:use #:cl)
  (:import-from :aoc-lisp/downloader #:download-input)
  (:export :aoc-lisp))
