;;;; comparse.lisp

(in-package #:comparse)

;;; Input protocol
;;; An input is a sequence of zero or more item
;;; items are atomic elements in the input
;;; when an item is consumed from the input it is remove from the input

(defgeneric input-empty-p (input)
  (:documentation "returns true if the input is empty else false"))

(defgeneric input-first (input)
  (:documentation "returns the nex element in the input"))

(defgeneric input-rest (input)
  (:documentation "returns the rest of the input that has not been yet consumed"))

;;; Input protocol for string

(defmethod input-empty-p ((input string))
  (zerop (length input)))

(defmethod input-first ((input string))
  (aref input 0))

(defmethod input-rest ((input string))
  (multiple-value-bind (string displacement)
      (array-displacement input)
    (make-array (1- (length input))
                :displaced-to (or string input)
                :displaced-index-offset (1+ displacement)
                :element-type (array-element-type input))))
