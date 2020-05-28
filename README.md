# closal

# Usage
```
(defclass a ()
  ((prefix :initform "e-"
           :allocation :class)
   (a :initform 0)))

(defclass b (a)
  ((b :initform 1)))

(obj->alist (make-instance 'b))

(obj->alist (alist->obj 'b (cl-json:decode-json-from-string "{ \"a\" : true }")))

```

## License

MIT
