;;;; aoc-lisp.lisp

(in-package #:aoc-lisp)

(defun hello-02()
  (print "test Vest"))

(defun show-input-02 (day)
  (let ((sum 0))
    (let* ((fileName (format nil "input~2,'0d.txt" day))
           (fileStream (open fileName)))
      (loop
        for line = (read-line fileStream nil)
        while line
        do (let ((game (is-game-valid line)))
             (setq sum (+ sum game))))
      (close fileStream))
    (print sum)
    )
  )

(defun split-line-02 (str)
  (cdr (ppcre:split "((: )|(, )|(; ))" str)))


(defun split-game-02 (str)
  (parse-integer (second (ppcre:split "(( )|(: ))" str))))


(defun split-token-02 (str)
  (let* ((result (ppcre:split " " str))
         (amount (parse-integer (first result)))
         (color (second result)))
    (list amount color)))

(defun is-enough (dice)
  (let ((a (first dice))
        (c (second dice)))
    (cond ((and (<= a 12) (string= c "red")) t)
          ((and (<= a 13) (string= c "green")) t)
          ((and (<= a 14) (string= c "blue")) t))))

(defun is-game-valid (game)
  (let* ((game-number (split-game-02 game))
         (dices-str (split-line-02 game))
         (dices (mapcar #'(lambda (x) (split-token-02 x)) dices-str))
         (first-invalid (find-if-not #'is-enough dices)))
        (if first-invalid 0 game-number)))
