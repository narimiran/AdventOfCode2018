#lang racket

(require "aoc.rkt"
         racket/generator
         threading)


(define (solve kids meta)
  (match kids
    [0
     (define ms (for/sum ([_ (in-range meta)]) (data)))
     (list ms ms)]
    [_
     (define kids-vals (make-hash))
     (define meta-sum
       (for/sum ([k (in-range kids)])
         (match-define (list ms kv) (solve (data) (data)))
         (hash-set! kids-vals (add1 k) kv)
         ms))
     (for/fold ([res (list meta-sum 0)])
               ([_ (in-range meta)])
       (define val (data))
       (map + res (list val (hash-ref kids-vals val 0))))]))


(define data
  (~>> (read-input-line 8)
       (extract-numbers)
       (in-list)
       (sequence->generator)))

(solve (data) (data))
