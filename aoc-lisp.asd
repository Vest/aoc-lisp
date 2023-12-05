;;;; aoc-lisp.asd

(asdf:defsystem #:aoc-lisp
  :description "aoc-lisp is an attempt to solve at least few days during AoC 2023"
  :author "Vest <Vest@users.noreply.github.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on ("dexador" "cl-ppcre")
  :components ((:file "package")
               (:file "aoc-lisp")
               (:file "aoc-lisp-01")
               (:file "aoc-lisp-02")
               (:file "aoc-lisp-03")
               ))

(asdf:defsystem #:aoc-lisp/test
  :description "Test for aoc-lisp, or at least an attempt to have it"
  :author "Vest <Vest@users.noreply.github.com>"
  :license "MIT"
  :depends-on (:aoc-lisp :fiveam)
  :components ((:file "aoc-lisp-01-test")
               (:file "aoc-lisp-02-test")
               (:file "aoc-lisp-03-test"))
  :perform (test-op (o c)
                     (symbol-call :fiveam :run!
                                  (find-symbol* :aoc-lisp :aoc-lisp/test))))
