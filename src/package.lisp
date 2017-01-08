;;;; package.lisp

(defpackage #:comparse
  (:use #:cl)
  (:export
   ;; Input protocol
   #:input-empty-p
   #:input-first
   #:input-rest

   ;; primitives
   #:.return
   #:.fail
   #:.item

   ;; Helper functions
   #:run
   #:parse

   ;; Combinators
   #:.bind
   #:.let*
   #:.satisfies
   #:.is
   #:.is-not

   ;; Parsers
   #:.char=
   #:.digit-char-p
   #:.lower-case-p
   #:.upper-case-p
   ))
