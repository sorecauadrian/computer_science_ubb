; 8. Șorecău Adrian-Vasile

; a) Write a function to return the difference of two sets.

; contains (elment, s1, ..., sn) = \ nil, s = []
;                                  \ true, element = s1
;                                  \ contains(element, s2, ..., sn), otherwise

; differenceOfTwoSets (x1, ..., xn, y1, ..., yn) = \ nil, x = []
;                                                  \ x1 U differenceOfTwoSets(x2, ..., xn, y1, ..., yn), contains(x1, y1, ..., yn) = false (nil)
;                                                  \ differenceOfTwoSets(x2, ..., xn, y1, ..., yn), otherwise

(defun contains (element set)
  (cond
    ; if the set is empty, then the element is not contained in the set
    ((null set) nil) 
    
    ; else if the element is equal to the first element of the set, then the element is contained in the set
    ((= element (car set)) T) 
    
    ; else we continue eliminating the first element of the set
    (T (contains element (cdr set))) 
  )
)

(defun differenceOfTwoSets (set1 set2)
  (cond
    ; if the first set is empty, then the difference is empty
    ((null set1) nil) 
    
    ; else if the first element of the first set is not contained in the second set, then we add it to the final result
    ((not (contains (car set1) set2)) (cons (car set1) (differenceOfTwoSets (cdr set1) set2))) 
    
    ; else we go to the next element of the first list
    (T (differenceOfTwoSets (cdr set1) set2)) 
  )
)

(format t "a)")
(print (differenceOfTwoSets '() '(1 4))) ; nil
(print (differenceOfTwoSets '(1 4) '())) ; (1 4)
(print (differenceOfTwoSets '(1 2 3 4) '(2 3 5 6 7 8 9))) ; (1 4)



; b) Write a function to reverse a list with its all sublists, on all levels.

; reverseList (l1, ..., ln) = \ nil, l = []
;                             \ reverseList(l2, ..., ln) U reverseList(l1), l1 is list
;                             \ reverseList(l2, ..., ln) U l1, otherwise

(defun reverseList (l)
  (cond 
    ; if the list is empty, then the revesed list is empty
    ((null l) nil)
    
    ; else if the first element of the list is a list, then we append the first element reversed to the remaining list reversed
    ((listp (car l)) (append (reverseList (cdr l)) (list (reverseList (car l)))))
    
    ; else we append the first element to the remaining list reversed
    (t (append (reverseList (cdr l)) (list (car l))))
  )
)

(terpri); newline
(terpri); newline
(format t "b)")
(print (reverseList '())); nil
(print (reverseList '(4 1))); (1 4)
(print (reverseList '(4 (4 (4 1) 1) 1))); (1 (1 (1 4) 4) 4)



; c) Write a function to return the list of the first elements of all list elements of a given list with an odd 
; number of elements at superficial level. Example: (1 2 (3 (4 5) (6 7)) 8 (9 10 11)) => (1 3 9).

; listLength(l1, ..., ln) = \ 0, l = []
;                           \ listLength(l2, ..., ln) + 1, otherwise

; removeNonLists(l1, ..., ln) = \ nil, l = []
;                               \ l1 U removeNonLists(l2, ..., ln), l1 is list
;                               \ removeNonLists(l2, ..., ln), otherwise

; firstElements(l1, ..., ln) = \ nil, l = []
;                              \ firstElements(l1) U firstElementsForAll(removeNonLists(l2, ..., ln)), l1 is list and n % 2 == 1
;                              \ l1 U firstElementsForAll(removeNonLists(l2, ..., ln)), l1 is not list and n % 2 == 1
;                              \ firstElements(removeNonLists(l2, ..., ln)), n % 2 == 0


(defun listLength (l)
  (cond
    ; if the list is empty, then the length is 0
    ((null l) 0)
    
    ; else the result is the length of the list without the first element + 1
    (T (+ (listLength (cdr l)) 1))
  )
)

(defun removeNonLists (l)
  (cond
    ; if the list is empty, then result is empty
    ((null l) nil)
    
    ; else if the firste element is a list, then we add it to the result and continue with the rest of the list
    ((listp (car l)) (cons (car l) (removeNonLists (cdr l))))
    
    ; else we continue with the rest of the list
    (t (removeNonLists (cdr l)))
  )
)

(defun firstElements (l)
  (cond
    ; if the list is empty, then the result is empty
    ((null l) nil)
    
    (
      ; else if the length of the list is odd
      (= (mod (listLength l) 2) 1)
      (cond
        ; if the first element is a list, then we apply firstElements to it and add it to the result (applying firstElements to the rest of the list after we remove its non-list elements)
        ((listp (car l)) (append (firstElements (car l)) (mapcan 'firstElements (removeNonLists (cdr l)))))
        
        ; else we add the element to the result (applying firstElements to the rest of the list after we remove its non-list elements)
        (t (append (list (car l)) (mapcan 'firstElements (removeNonLists (cdr l)))))
      )
    )
    
    ; else we contine applying firstElements to the rest of the list after removing all its non-list elements
    (t (firstElements (removeNonLists (cdr l))))
  )
)

;;; unfortunately i tried 2 hours to find a way to implement this function without using the mapping functions (mapcan, mapcar),
;;; but it was unsuccessful

(terpri); newline
(terpri); newline
(format t "c)")
(print (firstElements '())); nil
(print (firstElements '((1) 2 (3 (4 5) (6 7)) 8 (9 10 11)))); (1 3 9)
(print (firstElements '(((1) (2) (3)) ((4) (5)) ((6))))); (1 2 3 5 6)



; d) Write a function to return the sum of all numerical atoms in a list at superficial level.

; sumAllNumbers (l1, ..., ln) = \ 0, l = []
;                               \ l1 + sumAllNumbers(l2, ..., ln), l1 is number
;                               \ sumAllNumbers(l1) + sumAllNumbers(l2, ..., ln), l1 is list
;                               \ sumAllNumbers(l2, ..., ln), otherwise

(defun sumAllNumbers (l)
  (cond
    ; if the list is empty, then the sum is 0
    ((null l) 0)
    
    ; else
    (t 
      ; we add the sum of all the numbers from the rest of the list with
      (+ (sumAllNumbers (cdr l))
        (cond
          ; the element, if the first element is a number
          ((numberp (car l)) (car l))
          
          ; the sum of all the numbers of the element, if the first element is a list 
          ((listp (car l)) (sumAllNumbers (car l)))
          
          ; 0, otherwise
          (t 0)
        )
      )
    
    )
  )
)

(terpri); newline
(terpri); newline
(format t "d)")
(print (sumAllNumbers '())); 0
(print (sumAllNumbers '(1 2 3))); 6
(print (sumAllNumbers '(1 (2 3) (4 5 (6 a  b 7) 8 9) 10))); 55