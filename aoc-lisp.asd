;;;; aoc-lisp.asd

(asdf:defsystem #:aoc-lisp
  :description "aoc-lisp is an attempt to solve at least few days during AoC 2023/2024"
  :author "Vest <Vest@users.noreply.github.com>"
  :license  "MIT"
  :version "0.0.2"
  :serial t
  :depends-on (:dexador :cl-ppcre :uiop :drakma :str)
  :components ((:module "src"
                :components
               ((:file "package" :depends-on ("downloader"))
                (:file "downloader")
                (:file "aoc-lisp" :depends-on ("aoc-lisp-01" "aoc-lisp-02" "aoc-lisp-03"))
                (:file "aoc-lisp-01")
                (:file "aoc-lisp-02")
                (:file "aoc-lisp-03")
                (:file "aoc-lisp-2024-01" :depends-on ("downloader")))))
  :in-order-to ((test-op (test-op :aoc24-lisp/test))))

(asdf:defsystem #:aoc-lisp/test
  :description "Test for aoc-lisp, or at least an attempt to have it"
  :author "Vest <Vest@users.noreply.github.com>"
  :license "MIT"
  :depends-on (:aoc-lisp :fiveam)
  :components ((:module "test"
                :components
               ((:file "aoc-lisp-01-test")
               (:file "aoc-lisp-02-test")
               (:file "aoc-lisp-03-test"))))
  :perform (test-op (o c)
                     (symbol-call :fiveam :run!
                                  (find-symbol* :aoc-lisp :aoc-lisp/test))))
