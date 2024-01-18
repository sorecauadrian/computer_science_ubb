; 6 - Șorecău Adrian-Vasile - 927
; sa se construiasca multimea atomilor numerici ai unei liste.
; ex: (1 f (2 (1 3 e (2 4) 3) e 1) (1 4)) -> (1 2 3 4)

; liniarization (l1, ..., ln) =
;   = nil, n = 0
;   = l1, l1 is atom
;   = liniarization(l1), otherwise (l1 is list)
;   (with the observation that at the begining it will be liniarization (l), so we'll call this function for every element of the list)

(defun liniarization (l)
  (cond
    ((null l) nil)
    ((atom l) (list l))
    (t (mapcan #'(lambda (x) (liniarization x)) l))
  )
)

; onlyNumbers (l1, ..., ln) = 
;   = nil, n = 0
;   = l1 U onlyNumbers(l2, ..., ln), l1 is number 
;   = onlyNumbers(l2, ..., ln), otherwise

(defun onlyNumbers (l)
  (cond
    ((null l) nil)
    ((numberp (car l)) (cons (car l) (onlyNumbers (cdr l))))
    (t (onlyNumbers (cdr l)))
  )
)

; memberOf (element, l1, ..., ln) =
;   = nil, n = 0
;   = true, element = l1
;   = memberOf (element, l2, ..., ln), otherwise

(defun memberOf (e l)
  (cond
    ((null l) nil)
    ((= e (car l)) t)
    (t (memberOf e (cdr l)))
  )
)

; eliminateDuplicates (l1, ..., ln)
;   = nil, n = 0
;   = eliminateDuplicates (l2, ..., ln), memberOf l1 (l2, ..., ln)
;   = l1 U eliminateDuplicates(l2, ..., ln), otherwise

(defun eliminateDuplicates (l)
  (cond 
    ((null l) nil)
    ((memberOf (car l) (cdr l)) (eliminateDuplicates (cdr l)))
    (t (cons (car l) (eliminateDuplicates (cdr l))))
  )
)

; solution (l1, ..., ln) = eliminateDuplicates (onlyNumbers (liniarization (l1, ..., ln)))

(defun solution (l)
  (eliminateDuplicates (onlyNumbers (liniarization l)))
)

(print (solution '(1 f (2 (1 3 e (2 4) 3) e 1) (1 4))))
(print (solution '(1 (2 3 (4 5) 6))))
(print (solution '(a (b c d (e) f g))))
(print (solution '(1 b c (1 d 2 (a 2 a) e 1) h)))

; (print (liniarization '(1 f (2 (1 3 e (2 4) 3) e 1) (1 4))))
; (print (onlyNumbers '(1 F 2 1 3 E 2 4 3 E 1 1 4)))
; (print (eliminateDuplicates '(1 2 1 3 2 4 3 1 1 4)))