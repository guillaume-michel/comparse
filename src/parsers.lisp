(in-package :comparse)

(defun .char= (x)
  ;; parser for specific character: returns that character if it is the next item in the input else fails
  (.is #'char= x))

(defun .digit-char-p ()
  ;; digit parser
  (.is #'digit-char-p))

(defun .lower-case-p ()
  ;; lower case letter parser
  (.is #'lower-case-p))

(defun .upper-case-p ()
  ;; upper case letter parser
  (.is #'upper-case-p))
