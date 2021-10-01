#lang racket


(provide read-input read-input-line extract-numbers
         manhattan cat lower-alphabet upper-alphabet
         string->intlist number->intlist)

(require racket/format)
(require threading)


(define (read-input filename [datatype 'string])
  (~>> filename
       (~a _ #:align 'right #:min-width 2 #:pad-string "0")
       (format "inputs/~a.txt")
       (file->lines)
       ((match datatype
          ['int (curry map string->number)]
          ['list (curry map string->list)]
          ['string values]))))

(define (read-input-line filename [datatype 'string])
  (first (read-input filename datatype)))

(define (extract-numbers line #:neg [negative #t])
  (map string->number
       (regexp-match* (if negative #px"(-?\\d+)" #px"(\\d+)") line)))

(define (manhattan x [y '(0 0)])
  (+
    (abs (- (first x) (first y)))
    (abs (- (second x) (second y)))))

(define cat list->string)

(define lower-alphabet "abcdefghijklmnopqrstuvwxyz")
(define upper-alphabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

(define (string->intlist s)
  (for/list ([c (in-string s)])
    (- (char->integer c) 48)))

(define (number->intlist n)
  (let loop ([n n] [l empty])
    (cond
      [(zero? n) l]
      [else (loop (quotient n 10) (cons (modulo n 10) l))])))
