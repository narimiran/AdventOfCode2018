#lang racket

(require "aoc.rkt"
         threading)


(define (create-requirements data)
  (define requirements (make-hash))
  (for ([line (in-list data)])
    (match-define (list a b) line)
    (hash-update! requirements b (λ (v) (cons a v)) '()))
  requirements)

(define (solve part)
  (define remaining-letters
    (list->mutable-set (map string (string->list upper-alphabet))))
  (define end-times (make-hash)) ; for/hash would create an immutable hash-set
  (for ([l remaining-letters]) (hash-set! end-times l +inf.0))
  (define (processing-time s)
    (define (ord s)
      (char->integer (string-ref s 0)))
    (match part
      [1 1]
      [_ (- (ord s) 4)]))
  (define ((is-available? time) letter)
    (for/and ([l (in-list (hash-ref requirements letter '()))])
      (<= (hash-ref end-times l) time)))
  (define workers (if (= part 1) 1 5))
  (for/fold ([t 0]
             [w workers]
             [letters '()]
             #:result (if (= part 1)
                          letters
                          (apply max (hash-values end-times))))
            ([t (in-naturals)]
             #:break (set-empty? remaining-letters))
    (let*
        ([available-letters (~>> remaining-letters
                                 (set->list)
                                 (filter (is-available? t))
                                 (sort _ string<?))]
         [available-workers (min workers
                                 (+ w (count (λ (et) (= t (hash-ref end-times et t)))
                                             (hash->list end-times))))]
         [processed-letters (for/list ([l (in-list available-letters)]
                                       [w (in-range available-workers)])
                              (set-remove! remaining-letters l)
                              (hash-set! end-times l (+ t (processing-time l)))
                              l)]
         [employed-workers (length processed-letters)])
      (values t
              (- available-workers employed-workers)
              (append letters processed-letters)))))


(define data
  (map (curry regexp-match* #px" ([A-Z]) " #:match-select cadr)
       (read-input 7)))
(define requirements (create-requirements data))

(string-join (solve 1) "")
(solve 2)
