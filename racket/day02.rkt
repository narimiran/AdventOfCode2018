#lang racket

(require "aoc.rkt")



(define ((has-recurring? cnt) line)
  (for/or ([group (in-list (group-by values line char=?))])
    (= cnt (length group))))

(define ((count-recurring data) n)
  (count (has-recurring? n) data))

(define (part-1 data)
  (apply * (map (count-recurring data) '(2 3))))



(define (common-letters l1 l2)
  (for/list ([c1 (in-list l1)]
             [c2 (in-list l2)]
             #:when (char=? c1 c2))
    c1))

(define (differ-by-one? l1 l2)
  (=
    (sub1 (length l1))
    (length (common-letters l1 l2))))

(define (part-2 data)
  (for*/first ([l1 (in-list data)]
               [l2 (in-list (rest data))]
               #:when (differ-by-one? l1 l2))
    (cat (common-letters l1 l2))))



(define data (read-input 2 'list))
(part-1 data)
(part-2 data)
