;;;; closal.asd

(asdf:defsystem #:closal
  :description "Encode/Decode simple clos objects from/to alists."
  :author "Diego Guraieb <dgub@pm.pm>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :source-control (:git "git@github.com:diegogub/closal.git")
  :depends-on (#:closer-mop)
  :components ((:file "package")
               (:file "closal")))
