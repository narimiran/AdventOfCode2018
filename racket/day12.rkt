#lang racket

(require "aoc.rkt")


(define (parse-initial data)
  (define state (drop (string->list (first data)) 15))
  (for/list ([(c i) (in-indexed state)]
             #:when (char=? c #\#))
    i))

(define (extract-fruitful data)
  (define rules (drop data 2))
  (define (is-fruitful? rule)
    (define splitted (string-split rule))
    (and (string=? "#" (last splitted))
         (string->list (first splitted))))
  (filter-map is-fruitful? rules))

(define (grow plants)
  (define (creates-new-life? i)
    (define pattern
      (for/list ([j (in-inclusive-range (- i 2) (+ i 2))])
        (if (member j plants) #\# #\.)))
    (member pattern fruitful))
  (for/list ([i (in-inclusive-range (- (first plants) 2)
                                    (+ (last plants) 2))]
             #:when (creates-new-life? i))
    i))

(define (live plants [generations 20])
  (for/fold ([plants plants])
            ([_ (in-range generations)])
    (grow plants)))

(define (part-2 plants [generations 50000000000])
  (define after-200 (live plants 200))
  (define increase-rate
    (- (apply + (grow after-200))
       (apply + after-200)))
  (+ (apply + after-200)
     (* increase-rate (- generations 200))))


(define data (read-input 12))
(define initial-plants (parse-initial data))
(define fruitful (extract-fruitful data))

(apply + (live initial-plants))
(part-2 initial-plants)
