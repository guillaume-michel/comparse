;;;; comparse.asd

(asdf:defsystem #:comparse
  :description "A monadic parser combinator library"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "guillaume.michel@orilla.fr"
  :homepage "http://orilla.fr"
  :license "MIT license (see COPYING)"
  :depends-on (#:alexandria)
  :components ((:static-file "COPYING")
               (:static-file "README.md")
               (:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "input-protocol")
                                     (:file "primitives")
                                     (:file "helpers")
                                     (:file "combinators"))))
  :in-order-to ((asdf:test-op (asdf:test-op "comparse-tests"))))

(defmethod asdf:perform ((o asdf:test-op)
                         (c (eql (asdf:find-system '#:comparse))))
  (asdf:oos 'asdf:load-op '#:comparse-tests)
  (funcall (intern (symbol-name '#:run-tests) (find-package '#:comparse-tests))))
