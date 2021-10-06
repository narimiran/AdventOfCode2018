#lang racket

(require "aoc.rkt")


(define (find-limits coords)
  (define xs (map first coords))
  (define ys (map second coords))
  (list (cons (apply min xs) (apply max xs))
        (cons (apply min ys) (apply max ys))))

(define (find-owner pt coords)
  (define closest
    (sort coords < #:key (λ (c) (manhattan c pt)) #:cache-keys? #t))
  (if (= (manhattan (first closest) pt)
         (manhattan (second closest) pt))
      #f
      (first closest)))

(define (part-1 coords)
  (define owned-points (make-hash))
  (define (on-border? x y)
    (or (= x min-x) (= x max-x) (= y min-y) (= y max-y)))
  (for* ([x (in-inclusive-range min-x max-x)]
         [y (in-inclusive-range min-y max-y)])
    (define owner (find-owner (list x y) coords))
    (when owner
      (if (on-border? x y)
          (hash-set! owned-points owner #f)
          (hash-update! owned-points owner
                        (λ (val) (and val (add1 val))) 0))))
                        ; short circuit check if `val` was already set to `#f`
  (apply max (filter values (hash-values owned-points))))

(define (part-2 coords [max-dist 10000])
  (count
   (curryr < max-dist)
   (for*/list ([x (in-inclusive-range min-x max-x)]
               [y (in-inclusive-range min-y max-y)])
     (for/sum ([coord (in-list coords)])
       (manhattan (list x y) coord)))))



(define coords (map extract-numbers (read-input 6)))

(match-define
  (list (cons min-x max-x) (cons min-y max-y))
  (find-limits coords))

(part-1 coords)
(part-2 coords)
