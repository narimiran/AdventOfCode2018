#lang racket

(require "aoc.rkt"
         match-plus)


(define (positions data t)
  (for/list ([line (in-list data)])
    (match-define (list x y dx dy) line)
    (list (+ x (* dx t)) (+ y (* dy t)))))

(define (boundaries positions)
  (list
    (apply min (map first positions))
    (apply max (map first positions))
    (apply min (map second positions))
    (apply max (map second positions))))

(define/match* (area (list x-min x-max y-min y-max))
  (* (- x-max x-min) (- y-max y-min)))

(define (solve data)
  (define (size data t)
    (area (boundaries (positions data t))))
  (define initial-wait 10000) ; positions are ~10_000x larger than velocities
  (for/fold ([t 0]
             [prev-size +inf.0]
             #:result (sub1 t))
            ([t (in-naturals initial-wait)])
    (define sz (size data t))
    #:break (> sz prev-size)
    (values t sz)))

(define (show-message data time)
  (define stars (positions data time))
  (match-define (list x-min x-max y-min y-max) (boundaries stars))
  (for ([y (in-inclusive-range y-min y-max)])
    (for ([x (in-inclusive-range x-min x-max)])
      (display (if (member (list x y) stars) #\# #\space)))
    (newline)))


(define data (map extract-numbers (read-input 10)))

(define waiting-time (solve data))
(show-message data waiting-time)
waiting-time
