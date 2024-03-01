; 8. Șorecău Adrian-Vasile

; a) Write a function to return the difference of two sets.
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
(defun reverseList (l)
  (cond 
    ; if the list is empty, then the revesed list is empty
    ((null l) nil)
    
    ; else if the first element of the list is a list, then we append the first element reversed to the remaining list reversed
    ((listp (car l)) (append (reverseList (cdr l)) (list (reverseList (car l)))))
    
    ; else we append the first element to the remaining list reversed
    (t (append (reverseList (cdr l)) (list (car l))))
    
    ; here we must use append instead of cons
    
  )
)

(terpri)
(terpri)
(format t "b)")
(print (reverseList '())) ; nil
(print (reverseList '(4 1))) ; (1 4)
(print (reverseList '(4 (4 (4 1) 1) 1))); (1 (1 (1 4) 4) 4)



; c) Write a function to return the list of the first elements of all list elements of a given list with an odd 
; number of elements at superficial level. Example: (1 2 (3 (4 5) (6 7)) 8 (9 10 11)) => (1 3 9).

; firstElements(l1, ..., ln) = \ nil, l == []
;                             \ firstElements(l1) U firstElements(removeNonLists(l2, ..., ln)), l1 is list and n % 2 == 1
;                             \ l1 U firstElements(removeNonLists(l2, ..., ln)), l1 is not list and n % 2 == 1
;                             \ firstElements(removeNonLists(l2, ..., ln)), n % 2 == 0

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
    ((null l) nil)
    ((listp (car l)) (cons (car l) (removeNonLists (cdr l))))
    (t (removeNonLists (cdr l)))
  )
)

(defun firstElements (l)
  (cond
    ((null l) nil)
    (
      (= (mod (listLength l) 2) 1)
      (cond
        ((listp (car l)) (append (firstElements (car l)) (mapcan 'firstElements (removeNonLists (cdr l)))))
        (t (append (list (car l)) (mapcan 'firstElements (removeNonLists (cdr l)))))
      )
    )
    (t (firstElements (removeNonLists (cdr l))))
  )
)


(terpri)
(terpri)
(format t "c)")
(print (firstElements '((1) 2 (3 (4 12 5) (6 7)) 8 (9 10 11))))



; d) Write a function to return the sum of all numerical atoms in a list at superficial level.