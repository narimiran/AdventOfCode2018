#lang racket

(require "aoc.rkt"
         match-plus)


(struct point (x y) #:transparent)


(define (parse-claim line)
  (match-define (list _ x y w h) (extract-numbers line))
  (list (point x y) (point (+ x w) (+ y h))))

(define/match* (for-claim (list (point x1 y1) (point x2 y2)) func)
  (for*/and ([x (in-range x1 x2)]
             [y (in-range y1 y2)])
    (func (point x y))))

(define (populate-fabric claims)
  (define fabric (make-hash))
  (define (claim-fabric! claim)
    (for-claim claim (λ (pt) (hash-update! fabric pt add1 0))))
  (map claim-fabric! claims)
  fabric)

(define (part-1 fabric)
  (count (curryr >= 2) (hash-values fabric)))


(define (is-only-claimant? fabric claim)
  (for-claim claim (λ (pt) (= 1 (hash-ref fabric pt)))))

(define (part-2 fabric claims)
  (for/first ([(claim i) (in-indexed claims)]
              #:when (is-only-claimant? fabric claim))
    (add1 i)))



(define claims (map parse-claim (read-input 3)))
(define fabric (populate-fabric claims))

(part-1 fabric)
(part-2 fabric claims)
