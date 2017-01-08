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

;;; Combinators

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

(fiveam:test let*
  ;; same as bind test but with .let* (aka do notation for lisp)
  (fiveam:is (equal
              (let ((two-chars
                     (.let* ((char (.item))
                             (char2 (.item)))
                       (.return (cons char char2)))))
                (run two-chars "foo"))
              (list (cons (cons #\f #\o) "o")))))

(fiveam:test satisfies
  (fiveam:is (equal
              (run (.satisfies #'digit-char-p) "1 and")
              (list (cons #\1 " and")))))

(fiveam:test is-not
  (fiveam:is (equal
              (run (.is-not #'char= #\;) "foo;bar")
              (list (cons #\f "oo;bar")))))

(fiveam:test is-not-no-parse
  (fiveam:is (null (run (.is-not #'char= #\;) ";bar"))))

;;; Parsers

(fiveam:test char=
  (fiveam:is (equal
              (run (.char= #\x) "xyzzy")
              (list (cons #\x "yzzy")))))

(fiveam:test digit-char-p
  (fiveam:is (equal
              (run (.digit-char-p) "1234")
              (list (cons #\1 "234")))))

(fiveam:test lower-case-p
  (fiveam:is (equal
              (run (.lower-case-p) "abcd")
              (list (cons #\a "bcd")))))

(fiveam:test lower-case-p-fail
  (fiveam:is (null (run (.lower-case-p) "Doh!"))))

(fiveam:test upper-case-p
  (fiveam:is (equal
              (run (.upper-case-p) "Abcd")
              (list (cons #\A "bcd")))))

(fiveam:test upper-case-p-fail
  (fiveam:is (null (run (.upper-case-p) "doh!"))))

(defun run-tests ()
  (princ "Running all comparse unit tests")
  (fiveam:run! 'comparse-test-suite))
