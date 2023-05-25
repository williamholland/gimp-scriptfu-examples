; return ints from 0 to n exclusive of n
(define (range n)
  (let loop ((i 0) (result '()))
    (if (< i n)
      (loop (+ i 1) (cons i result))
      (reverse result))))
