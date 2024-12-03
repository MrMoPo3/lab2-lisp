(defun group-pairs-and-reverse (lst)
  (labels ((group-helper (lst acc)
             (cond
               ((null lst) acc)
               ((null (cdr lst)) (cons (list (car lst)) acc))
               (t (group-helper (cddr lst)
                                (cons (list (car lst) (cadr lst)) acc))))))
    (group-helper lst '())))

(defun check-group-pairs-and-reverse (name input expected)
  (let ((result (group-pairs-and-reverse input)))
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (not (equal result expected))
            name expected result)))

(defun test-group-pairs-and-reverse ()
  (format t "Start testing group-pairs-and-reverse function~%")
  (check-group-pairs-and-reverse "test 1" '(a b c d e f g) '((g) (f e) (d c) (b a)))
  (check-group-pairs-and-reverse "test 2" '(1 2 3 4 5) '((5) (4 3) (2 1)))
  (check-group-pairs-and-reverse "test 3" '(x y z) '((z) (y x)))
  (check-group-pairs-and-reverse "test 4" '(nil 1 nil 2) '((2) (1 nil) (nil)))
  (check-group-pairs-and-reverse "test 5" '() '())
  (format t "End of tests~%"))

(test-group-pairs-and-reverse)

(defun cyclic-shift-left (lst n)
  (labels ((shift-helper (lst n)
             (if (zerop n)
                 lst
                 (shift-helper (append (cdr lst) (list (car lst))) (1- n)))) )
    (let ((len (length lst)))
      (if (zerop len)
          lst
          (shift-helper lst (mod n len))))))

(defun check-cyclic-shift-left (name input n expected)
  (let ((result (cyclic-shift-left input n)))
    (if (equal result expected)
        (format t "~a passed! Expected: ~a Obtained: ~a~%" name expected result)
        (format t "~a failed! Expected: ~a Obtained: ~a~%" name expected result))))

(defun test-cyclic-shift-left ()
  (format t "Start testing cyclic-shift-left function~%")
  (check-cyclic-shift-left "test 1" '(1 2 3 4 5 6) 2 '(3 4 5 6 1 2))
  (check-cyclic-shift-left "test 2" '(1 2 3 4 5 6) 0 '(1 2 3 4 5 6))
  (check-cyclic-shift-left "test 3" '() 3 '())
  (check-cyclic-shift-left "test 4" '(1 2 3 4 5 6) 7 '(2 3 4 5 6 1))
  (check-cyclic-shift-left "test 5" '(5) 1 '(5))
  (format t "End of tests~%"))

(test-cyclic-shift-left)

        
