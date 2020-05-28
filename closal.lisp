;;;; closal.lisp

(in-package #:closal)

(defun map-obj-slots (obj)
"Creates a ALIST of obj CLASS slots."
(map 'list
     #'(lambda (slot-name)
         `(,(intern (string-upcase slot-name) :keyword) . ,slot-name)
        )
     (map 'list #'(lambda (slot)
            (closer-mop:slot-definition-name slot)
                    ) 
     (closer-mop:class-slots (find-class obj)))))

(defun alist-obj (class vals)
  "Return a instance of type CLASS, based on ALIST vals."
  (let ((m (map-obj-slots class))
    (obj (make-instance class)))
    (if (typep vals 'list)
        (loop :for (key . value) :in vals
      :when (assoc key m) :do (setf (slot-value obj (cdr (assoc key m))) value))) 
    obj))

(defun obj-alist (obj)
  "Return a ALIST from a obj, CLASS INSTANCE."
  (typecase obj
    (cons  obj)
    (string obj)
    (number obj)
    (list  (map 'list #'obj->alist obj))
    (vector (map 'vector #'obj->alist obj))
    (t (let ((c (find-class (type-of obj) nil)))
      (if c
        (map 'list 
             #'(lambda (slot)
                (let ((name (closer-mop:slot-definition-name slot)))
                `( ,(intern (string-upcase name) :keyword) . ,(obj->alist(slot-value obj name)))))
          (closer-mop:class-slots c))           
          obj)))
    ))
