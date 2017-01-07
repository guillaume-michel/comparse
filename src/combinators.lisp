(in-package #:comparse)

(defun .bind (parser function)
  ;; Parser monad bind operator
  ;; bind :: Parser s a -> (a -> Parser s b) -> Parser s b
  ;; allows parsers to be chained
  (lambda (input)
    (loop :for (value . input) :in (run parser input)
       :append (run (funcall function value) input))))
