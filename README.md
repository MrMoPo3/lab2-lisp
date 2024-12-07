<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right">Студент: Левчук Іван Володимирович група КВ-12<p>
<p align="right">Рік: 2024<p>
 
## Загальне завдання	
Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за
можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно
реалізувати, задаються варіантом (п. 2.1.1). Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового
списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій
для роботи зі списками, що не наведені в четвертому розділі навчального
посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції
в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.
Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (див. п. 2.3).

## Варіант 14
1.Написати функцію group-pairs-and-reverse , яка групує послідовні пари
елементів у списки i повертає обернений результат:

  ```lisp
  CL-USER> (group-pairs-and-reverse '(a b c d e f g))
((G) (E F) (C D) (A B))
```

2.Написати функцію cyclic-shift-left , яка виконує циклічний зсув елементів
списку ліворуч на задане число позицій:

  ```lisp
CL-USER> (cyclic-shift-left '(1 2 3 4 5 6) 2)
(3 4 5 6 1 2)
```

## Лістинг функції group-pairs-and-reverse

  ```lisp
(defun group-pairs-and-reverse (lst)
  (labels ((group-helper (lst acc)
             (cond
               ((null lst) acc)
               ((null (cdr lst)) (cons (list (car lst)) acc))
               (t (group-helper (cddr lst)
                                (cons (list (car lst) (cadr lst)) acc))))))
    (group-helper lst '())))
```

### Тестові набори

  ```lisp
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
  (check-group-pairs-and-reverse "test 4" '() '(nil))
  (check-group-pairs-and-reverse "test 5" '(x y c) '((c) (x y)))
  (format t "End of tests~%"))
```

### Тестування

  ```lisp
 (test-group-pairs-and-reverse)
Start testing group-pairs-and-reverse function
test 1 passed! Expected: ((G) (F E) (D C) (B A)) Obtained: ((G) (E F) (C D)
                                                            (A B))
test 2 passed! Expected: ((5) (4 3) (2 1)) Obtained: ((5) (3 4) (1 2))
test 3 passed! Expected: ((Z) (Y X)) Obtained: ((Z) (X Y))
test 4 passed! Expected: (NIL) Obtained: NIL
test 5 passed! Expected: ((C) (Y X)) Obtained: ((C) (X Y))
End of tests
```

## Лістинг функції cyclic-shift-left

  ```lisp
(defun cyclic-shift-left (lst n)
  (labels ((shift-helper (lst n)
             (if (zerop n)
                 lst
                 (shift-helper (append (cdr lst) (list (car lst))) (1- n)))) )
    (let ((len (length lst)))
      (if (zerop len)
          lst
          (shift-helper lst (mod n len))))))
```

### Тестові набори

  ```lisp
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
```

### Тестування

  ```lisp
(test-cyclic-shift-left)
Start testing cyclic-shift-left function
test 1 passed! Expected: (3 4 5 6 1 2) Obtained: (3 4 5 6 1 2)
test 2 passed! Expected: (1 2 3 4 5 6) Obtained: (1 2 3 4 5 6)
test 3 passed! Expected: NIL Obtained: NIL
test 4 passed! Expected: (2 3 4 5 6 1) Obtained: (2 3 4 5 6 1)
test 5 passed! Expected: (5) Obtained: (5)
End of tests
```
