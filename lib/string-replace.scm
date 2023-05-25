; given a string replace to-replace (string) with replace-with (string)
(define (string-replace str to-replace replace-with)
  (define (string-prefix? prefix str)
  (and (<= (string-length prefix) (string-length str))
       (string=? (substring str 0 (string-length prefix)) prefix)))
  (let ((result ""))
    (let loop ((i 0))
      (cond ((>= i (string-length str)) result)
            ((string-prefix? to-replace (substring str i))
             (set! result (string-append result replace-with))
             (loop (+ i (string-length to-replace))))
            (else
             (set! result (string-append result (string (string-ref str i))))
             (loop (+ i 1)))))))