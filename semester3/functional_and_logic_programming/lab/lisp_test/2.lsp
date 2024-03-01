; dandu-se o lista liniara, sa se stearga toate secventele de valori numerice consecutive.
; (1 2 c 4 6 7 8 i 10 j) -> (c 4 i 10 j)
; (1 2 3 5 7 8 9 10) -> (5)
; (a b 4 c s 5 6 b) -> (a b 4 c s b)
; (1 a 2 b 3 4 c d 5 6 7 e) -> (1 a 2 b c d e)

(defun eliminateConsecutiveValues (l flag)
  (cond
    ((null l) nil)
    ((and (numberp (car l)) (numberp (cadr l)) (= (+ 1 (car l)) (cadr l))) (eliminateConsecutiveValues (cdr l) 1))
    ((= flag 1) (eliminateConsecutiveValues (cdr l) 0))
    (t (cons (car l) (eliminateConsecutiveValues (cdr l) 0)))
  )
)

(defun deleteConsecutive (l)
  (eliminateConsecutiveValues l 0)
)

(print (deleteConsecutive '(1 2 c 4 6 7 8 i 10 j)))
(print (deleteConsecutive '(1 2 3 5 7 8 9 10)))
(print (deleteConsecutive '(a b 4 c s 5 6 b)))
(print (deleteConsecutive '(1 a 2 b 3 4 c d 5 6 7 e)))