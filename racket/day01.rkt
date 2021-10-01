#lang racket

(require racket/set
         "aoc.rkt")


(define data (read-input 1 'int))

(apply + data)

(for/fold ([accum 0]
           [seen (set)]
           #:result accum)
          ([freq (in-cycle data)]
           #:break (set-member? seen accum))
  (values (+ accum freq) (set-add seen accum)))
