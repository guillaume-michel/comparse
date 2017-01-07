;;;; comparse.asd

(asdf:defsystem #:comparse-tests
  :description "comparse unit tests"
  :author "Guillaume MICHEL"
  :mailto "guillaume.michel@orilla.fr"
  :license "MIT license (see COPYING)"
  :depends-on (#:comparse
               #:fiveam)
  :components ((:module "t"
                :serial t
                :components ((:file "package")
                             (:file "tests")))))
