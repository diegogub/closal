;;;; closal.lisp

(in-package #:closal)

(defun map-obj-slots (obj)
"Creates a ALIST of obj CLASS slots."
(map 'list
     #'(lambda (slot-name)
         `(,(intern (string-upcase slot-name) :keyword) . ,slot-name)
        )
     (map 'list #'(lambda (slot)
            (sb-mop:slot-definition-name slot)
               ) 
     (sb-mop:class-slots (find-class obj)))))

(defun alist->obj (class vals)
  "Return a instance of type CLASS, based on ALIST vals."
  (let (
        (m (map-obj-slots class))
        (obj (make-instance class)))
    (if (typep vals 'list)
        (map nil #'(lambda (val)
            (progn
              (let (slot (assoc (cdr val) m))
                (if slot
                  (setf (slot-value obj (cdr slot)) (cdr val))
                  nil
                ))
              nil
              )
            )

            vals
          )
    ) 
    obj
  ))

(defun obj->alist (obj)
  "Return a ALIST from a obj, CLASS INSTANCE."
  (progn
  (typecase obj
    (cons  obj)
    (string obj)
    (number obj)
    (list  (map 'list #'encode obj))
    (vector (map 'vector #'encode obj))
    (array (map (type-of obj) #'encode obj))
    (t (let ((c (find-class (type-of obj) nil)))
      (if c
        (map 'list #'(lambda (slot)
                      (let (
                            (name (sb-mop:slot-definition-name slot))
                           )
                          `( ,(intern (string-upcase name) :keyword) . ,(encode (slot-value obj name)))
                        ))
          (sb-mop:class-slots c))           

          obj
      )))
    )))
