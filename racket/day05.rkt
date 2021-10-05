#lang racket

(require "aoc.rkt"
         threading)


(define (reactions polymer)
  (define (is-reaction? n1 n2)
    (= 32 (bitwise-xor n1 n2)))
  (for/fold ([accum '(-1)]
             #:result (rest (reverse accum)))
            ([n (in-list polymer)])
    (if (is-reaction? n (first accum))
        (rest accum)
        (cons n accum))))

(define (shortest polymer)
  (for/fold ([accum +inf.0]
             #:result (inexact->exact accum))
            ([n (in-inclusive-range (char->integer #\A)
                                    (char->integer #\Z))])
    (~>> polymer
         (filter-not (λ (i) (or (= i n) (= i (+ n 32)))))
         (reactions)
         (length)
         (min accum))))


(define data (map char->integer (read-input-line 5 'list)))

(define resulting-polymer (reactions data))
(length resulting-polymer)
(shortest resulting-polymer)
