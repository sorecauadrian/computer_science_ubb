; sa se stearga dintr-o lista neliniara toate sublistele (liniare) care au numar par de elemente.
; ex: ((2 3 4) (6 (7 8) ((7 9) 8)) (6 8) 9) -> ((2 3 4) (6 (8)) 9)

(defun isLinear (l)
  (cond
    ((null l) t)            ; if its an empty list, then its linear
    ((listp (car l)) nil)   ; else if its first element is a list, then its not linear
    (t (isLinear (cdr l)))  ; otherwise we contine without the first element
  )
)

(defun deleteEvenLengthSublists (l)
  (cond
    ((null l) nil)
    ((listp (car l))
      (cond
        ((isLinear (car l))
          (cond 
            ((= (mod (length (car l)) 2) 0) (deleteEvenLengthSublists (cdr l)))
            (t (cons (car l) (deleteEvenLengthSublists (cdr l))))
          )
        )
        (t (cons (deleteEvenLengthSublists (car l)) (deleteEvenLengthSublists (cdr l))))
      )
    )
    (t (cons (car l) (deleteEvenLengthSublists (cdr l))))
  )
)

(print (deleteEvenLengthSublists '((2 3 4) (6 (7 8) ((7 9) 8)) (6 8) 9)))