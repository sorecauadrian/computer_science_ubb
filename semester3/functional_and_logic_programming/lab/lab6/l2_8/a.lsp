; 8. Șorecău Adrian-Vasile

; a binary tree is memorised in the following way:
;     (node (list-subtree-1) (list-subtree-2) ...)

; as an example, the tree
;   A
;  / \
; B  C
;   / \
;  D  E
; is represented as follows:
; (A (B) (C (D) (E)))


; 8. return the list of nodes of a tree accessed inorder.

; leftSubtree (t1, ..., tn) = \ nil, t = [] or t is not list (its an element, so it doesn't have left or right subtrees)
;                             \ t2, otherwise

; rightSubtree (t1, ..., tn) = \ nil, tree = [] or tree is not list (its an element, so it doesn't have left or right subtrees)
;                              \ t3, otherwise

; inorder (t1, ..., tn) = \ nil, t = []
;                         \ inorder(leftSubtree(t1, ..., tn)) U t1 U inorder(rightSubtree(t1, ..., tn))

(defun leftSubtree (tree)
  (cond
    ((null tree) nil)
    ((not (listp tree)) nil)
    (t (cadr tree))
  )
)

(defun rightSubtree (tree)
  (cond
    ((null tree) nil)
    ((not (listp tree)) nil)
    (t (caddr tree))
  )
)

(defun inorder (tree)
  (cond 
    ((null tree) nil)
    (t (append (inorder (leftSubtree tree)) (list (car tree)) (inorder (rightSubtree tree))))
  )
)

(print (inorder '())); nil
(print (inorder '(A))); A
(print (inorder '(A (B (C))))); C B A
(print (inorder '(A (B) (C (D) (E))))); B A D C E (example)
(print (inorder '(A () (B () (C))))); A B C
