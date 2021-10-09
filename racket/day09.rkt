#lang racket


(struct marble (value left right) #:mutable)


(define (initialize)
  (define initial-marble (marble 0 #f #f))
  (set-marble-left! initial-marble initial-marble)
  (set-marble-right! initial-marble initial-marble)
  initial-marble)

(define (insert-marble current value)
  (let* ([new-left (marble-right current)]
         [new-right (marble-right new-left)]
         [new-marble (marble value new-left new-right)])
    (set-marble-right! new-left new-marble)
    (set-marble-left! new-right new-marble)
    new-marble))

(define (remove-marble current)
  (let* ([to-remove (for/fold ([m current])
                              ([_ (in-range 7)])
                      (marble-left m))]
         [left-marble (marble-left to-remove)]
         [right-marble (marble-right to-remove)])
    (set-marble-right! left-marble right-marble)
    (set-marble-left! right-marble left-marble)
    (values right-marble (marble-value to-remove))))

(define (play players rounds)
  (define (current-player rd) (modulo rd players))
  (let ([circle (initialize)]
        [scores (make-vector (add1 players))])
    (for/fold ([current-marble circle]
               #:result (apply max (vector->list scores)))
              ([rd (in-inclusive-range 1 rounds)])
      (cond
        [(zero? (modulo rd 23))
         (define-values (new-current value) (remove-marble current-marble))
         (let* ([player (current-player rd)]
                [current-score (vector-ref scores player)])
           (vector-set! scores player (+ current-score rd value)))
         new-current]
        [else
         (insert-marble current-marble rd)]))))


(define players-nr 410)
(define marbles-nr 72059)

(play players-nr marbles-nr)
(play players-nr (* 100 marbles-nr))
