;;;; aoc-lisp.asd

(asdf:defsystem #:aoc-lisp
  :description "aoc-lisp is an attempt to solve at least few days during AoC 2023"
  :author "Vest <Vest@users.noreply.github.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on ("dexador")
  :components ((:file "package")
               (:file "aoc-lisp")))
