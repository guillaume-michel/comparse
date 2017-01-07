;;;; (asdf:operate 'asdf:test-op :comparse)

(in-package :comparse-tests)

(fiveam:def-suite comparse-test-suite
    :description "Comparse test suite.")

(fiveam:in-suite comparse-test-suite)

;;; Input protocol Tests

(fiveam:test input-empty-p-with-empty
  (fiveam:is (input-empty-p "")))

(fiveam:test input-empty-p-with-non-empty
  (fiveam:is (null (input-empty-p "foo"))))

(fiveam:test input-first
  (fiveam:is (char= (input-first "foo") #\f)))

(fiveam:test input-rest
  (fiveam:is (string= (input-rest "foo") "oo")))

;;; Primitives Tests

(fiveam:test return
  (fiveam:is (equal (run (.return :foo) "bar baz") (list (cons :foo "bar baz")))))

(fiveam:test fail
  (fiveam:is (null (run (.fail) "foo"))))

(fiveam:test item-non-empty
  (fiveam:is (equal (run (.item) "foo") (list (cons #\f "oo")))))

(fiveam:test item-empty
  (fiveam:is (null (run (.item) ""))))

(fiveam:test bind
  (fiveam:is (equal
              (let ((two-chars
                     (.bind (.item)
                            (lambda (char)
                              (.bind (.item)
                                     (lambda (char2)
                                       (.return (cons char char2))))))))
                (run two-chars "foo"))
              (list (cons (cons #\f #\o) "o")))))

(defun run-tests ()
  (princ "Running all comparse unit tests")
  (fiveam:run! 'comparse-test-suite))
