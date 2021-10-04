#lang racket

(require "aoc.rkt")


(define (parse-input data)
  (define (meaningful-letter line)
    (string-ref line (- (string-length line) 2)))
  (define guards (make-hash))
  (for/fold ([current-guard 0]
             [sleep-start 0])
            ([line (in-list data)])
    (define last-digit (last (extract-numbers line)))
    (match (meaningful-letter line)
      [#\f (values last-digit sleep-start)]     ; ...shiFt
      [#\e (values current-guard last-digit)]   ; ...asleEp
      [#\u                                      ; ...wakes Up
       (define v (hash-ref guards current-guard (make-vector 60)))
       (for ([m (in-range sleep-start last-digit)])
         (vector-set! v m (add1 (vector-ref v m))))
       (hash-set! guards current-guard v)
       (values current-guard sleep-start)]))
  guards)

(define (solve part)
  (for/fold ([guard-nr 0]
             [sleeping-time 0]
             [sleepiest-minute 0]
             #:result (* guard-nr sleepiest-minute))
            ([guard (in-hash-keys guards)])
    (define l (vector->list (hash-ref guards guard)))
    (define sleeping-amount (apply + l))
    (define-values (current-sleepiest-minute sleepiest-minute-amount)
      (for/fold ([amount 0]
                 [minute 0]
                 #:result (values minute amount))
                ([(v m) (in-indexed l)])
        (if (> v amount)
            (values v m)
            (values amount minute))))
    (define condition
      (match part
        [1 sleeping-amount]
        [2 sleepiest-minute-amount]))
    (if (> condition sleeping-time)
        (values guard condition current-sleepiest-minute)
        (values guard-nr sleeping-time sleepiest-minute))))


(define data (sort (read-input 4) string<?))
(define guards (parse-input data))

(solve 1)
(solve 2)
