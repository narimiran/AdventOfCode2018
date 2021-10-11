#lang racket

(require threading)


(define (power-level x y)
  (~> serial
    (+ (* (+ x 10) y))
    (* (+ x 10))
    (quotient 100)
    (modulo 10)
    (- 5)))

(define (square-sum grid x y [size 3])
  (- (hash-ref grid (list x y) 0)
     (hash-ref grid (list x (- y size)) 0)
     (hash-ref grid (list (- x size) y) 0)
     (- (hash-ref grid (list (- x size) (- y size)) 0))))

(define (create-grid)
  (define grid (make-hash))
  (for* ([x (in-inclusive-range 1 grid-size)]
         [y (in-inclusive-range 1 grid-size)])
    (hash-set! grid (list x y) (- (power-level x y) (square-sum grid x y 1))))
  grid)

(define (most-powerful grid [size 3])
  (for*/fold ([largest '(0 0 0 0)])
             ([x (in-inclusive-range size grid-size)]
              [y (in-inclusive-range size grid-size)])
    (define power (square-sum grid x y size))
    (if (> power (last largest))
      (list (- x (sub1 size)) (- y (sub1 size)) size power)
      largest)))

(define (most-powerful-any-size grid)
  (for/fold ([largest '(0 0 0 0)])
            ([size (in-range 2 grid-size)])
    (define res (most-powerful grid size))
    (if (> (last res) (last largest))
        res
        largest)))



(define serial 4172)
(define grid-size 300)

(define grid (create-grid))
(take (most-powerful grid) 2)
(take (most-powerful-any-size grid) 3)
