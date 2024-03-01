; 8. Șorecău Adrian-Vasile

; write a function to determine the number of nodes on the level k from a n-tree represented as follows: 
;   (root list_nodes_subtree1 ... list_nodes_subtreen) 
; eg: tree is (a (b (c)) (d) (e (f))) and k=1 => 3 nodes

; numberOfNodesOnSpecificLevel (level, t1, ..., tn) = \ 0, t = []
;                                                     \ numberOfNodesOnSpecificLevel(level, t2, ..., tn), level = 0 and t1 is list
;                                                     \ numberOfNodesOnSpecificLevel(level, t2, ..., tn) + 1, level = 0 and t1 is not list
;                                                     \ numberOfNodesOnSpecificLevel(level - 1, t1) + numberOfNodesOnSpecificLevel(level, t2, ..., tn), level != 0 and t1 is list
;                                                     \ numberOfNodesOnSpecificLevel(level, t2, ..., tn), level != 0 and t1 is not list

(defun numberOfNodesOnSpecificLevel (level tree)
  (cond
    ((null tree) 0)
    ((= level 0)
      (cond
        ((listp (car tree)) (numberOfNodesOnSpecificLevel level (cdr tree)))
        (t (+ (numberOfNodesOnSpecificLevel level (cdr tree)) 1))
      )
    )
    (t
      (cond
        ((listp (car tree)) (+ (numberOfNodesOnSpecificLevel (- level 1) (car tree)) (numberOfNodesOnSpecificLevel level (cdr tree))))
        (t (numberOfNodesOnSpecificLevel level (cdr tree)))
      )
    )
  )
)

(print (numberOfNodesOnSpecificLevel '1 '(a (b (c)) (d) (e (f))) ))

; numberOfNodesOnSpecificLevelMap(level, t1, ..., tn) = | 0, t = [] or level < 0
;                                                       | numberOfNodesOnSpecificLevelMap(level - 1, t2, ..., tn) + numberOfNodesOnSpecificLevelMap(level - 1, t1), t1 is list
;                                                       | numberOfNodesOnSpecificLevelMap(level - 1, t2, ..., tn) + 1, level = 0 and t1 is not list
;                                                       | numberOfNodesOnSpecificLevelMap(level - 1, t2, ..., tn), otherwise

(defun numberOfNodesOnSpecificLevelMap (level tree)
  (cond
    ((or (null tree) (< level 0)) 0)
    (t
      (+ (apply '+ (mapcar #'(lambda (tree) (numberOfNodesOnSpecificLevelMap (- level 1) tree)) (cdr tree)))
        (cond
          ((listp (car tree)) (apply '+ (mapcar #'(lambda (tree) (numberOfNodesOnSpecificLevelMap (- level 1) tree)) (car tree))))
          (t 
            (cond
              ((= level 0) 1)
              (t 0)
            )
          )
        )
      )
    )
  )
)

(print (numberOfNodesOnSpecificLevelMap '1 '(a (b (c)) (d) (e (f)))))