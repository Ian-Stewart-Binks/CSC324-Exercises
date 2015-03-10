#lang racket
; Exercise 1: Write a function to determine the length of a list.
(define (length lst) (foldl (lambda (x y) (+ y 1)) 0 lst))

; Exercise 2: Write a function to determine if a given element appears in a list.
(define (appears lst item) (> (length (filter (lambda (x) (equal? x item)) lst)) 0))

; Exercise 3: Write a function to determine the number of duplicates in a list.
(define (num_duplicates lst) (- (length lst) (length (remove-duplicates lst))))

; Exercise 4: Write a function to remove all duplicates from a list.
(define (remove_duplicates lst) (foldl (lambda (x y) (if (member x (remove x y)) (remove x y) y)) lst lst))

; Exercise 5 a: Given two lists, output the items that appear in both lists (intersection).
(define (intersection lst1 lst2) (let ([lst3 (filter (lambda (x) (member x lst2)) lst1)])
                                   (append lst3 (filter (lambda (x) (and (member x lst1) (not (member x lst3)))) lst2))))

; Exercise 5 b: Then, output the items that appear in at least one of the two lists.
(define (union lst1 lst2) (remove-duplicates (append lst1 lst2)))

; Exercise 6: Write a function which takes a list of lists, and returns the list which contains the largest item.
; Perhaps this function could be improved with folding.
(define (get-largest-sublist lsts) (filter (lambda (x) (if (empty? x) #f
                                                           (= (first (max-list x)) (first (max-list (get-all-max-vals lsts))))))
                                           lsts))

; Get all max values of every sublist.
(define (get-all-max-vals lsts) (map (lambda (y) (first (max-list y))) (filter (lambda (x) (not (empty? x))) lsts)))

; Get the largest element of a list.
(define (max-list lst) (filter (lambda (x) (empty? (filter (lambda (y) (> y x)) lst))) lst))

; Exercise 7: Write a function which takes an item and a list of lists and inserts the function in the front of every list
(define (insert-at-front item lsts) (map (lambda (x) (cons item x)) lsts))

; Exercise 8: Write a function which takes a list with no duplicates representing a set (order doesn't matter).
; Returns a list of lists containing all of the subsets of that list.
(define (subsets set) (cons '() (foldl (lambda (x y) (append (insert-at-front x (cons '() y)) y)) '() set)))

; Exercise 9: Write a function taking a list with no duplicates, and a number k, and returns all subsets of size k
;             of that list.
(define (subsets-size-k set k) (filter (lambda (x) (= (length x) k)) (subsets set)))

; Exercise 10: Modify your function to the previous question so that the parameter k is optional
;              and if not specified, the function returns all subsets.
(define (subsets-size-k-optional set [k -1]) (if (= k -1) 
                                                (subsets set)
                                                (subsets-size-k set k)))