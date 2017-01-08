(in-package #:comparse)

(defun .bind (parser function)
  ;; Parser monad bind operator
  ;; bind :: Parser s a -> (a -> Parser s b) -> Parser s b
  ;; allows parsers to be chained
  (lambda (input)
    (loop :for (value . input) :in (run parser input)
       :append (run (funcall function value) input))))

(defmacro .let* (bindings &body body)
  ;; emulate "do notation" for lispers
  (if bindings
      (let ((symbol (first (first bindings))))
        `(.bind ,@(cdr (first bindings))
                (lambda (,symbol)
                  ,@(when (or (string-equal (symbol-name symbol) "_")
                              (null (symbol-package symbol)))
                      `((declare (ignorable ,symbol))))
                  (.let* ,(cdr bindings)
                         ,@body))))
      `(progn ,@body)))

(defun .satisfies (predicate &rest args)
  ;; consumes 1 item from input only if predicate is true
  (.let* ((x (.item)))
    (if (apply predicate x args)
        (.return x)
        (.fail))))

(defun .is-not (predicate &rest args)
  ;; consume 1 item from input if predicate is false
  (.satisfies (lambda (i)
                (not (apply predicate i args)))))

(defun .is (predicate &rest args)
  ;; same as .satisfies
  (apply #'.satisfies predicate args))
