(in-package #:comparse)

;;; Parser is a Monad plus with a zero
;;; type Parser s a = s -> [(a,s)]
;;; s is the stream type (e.g String or Stream)
;;; a is the return type

(defun .return (value)
  ;; result :: a -> Parser s a
  ;; Parser monad return function
  ;; parser which always succeeds by returning the value passed to it, and does not consume any input
  (lambda (input)
    (list (cons value input))))

(defun .fail ()
  ;; fail :: Parser s a
  ;; Parser monad zero function
  ;; parser which simply fails regardless of the input
  (lambda (input)
    (declare (ignore input))
    nil))

(defun .item ()
  ;; item :: Parser s a
  ;; parser that consumes the first (next) item in the input, or fails if the input is empty
  (lambda (input)
    (unless (input-empty-p input)
      (list (cons (input-first input)
                  (input-rest input))))))
