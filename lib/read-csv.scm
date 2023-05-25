; this script contains some useful CSV functions:

; 1) read-csv-line - read one line of a csv from a fileport and return a list
; 2) read-csv - read a CSV into a list of lists

(define (read-csv-line file-port separator-char quote-char)
  (let loop ((line '())
             (field '())
             (quoted? #f)
             (char (read-char file-port)))
    (cond
      ((or (char=? char #\newline) (eof-object? char))
       (if (null? field)
           (reverse line)
           (reverse (cons (list->string (reverse field)) line))))
      ((char=? char separator-char)
       (if quoted?
           (loop line (cons char field) #t (read-char file-port))
           (loop (cons (list->string (reverse field)) line) '() #f (read-char file-port))))
      ((char=? char quote-char)
       (if quoted?
           (loop line field #f (read-char file-port))
           (loop line field #t (read-char file-port))))
      (else
       (loop line (cons char field) quoted? (read-char file-port))))))

(define (read-csv file-port separator-char quote-char)
  (let loop ((data '())
             (row '())
             (field '())
             (quoted? #f)
             (char (read-char file-port)))
    (cond
      ((eof-object? char)
       (if (null? field)
           (if (null? row)
               (reverse data)
               (reverse (cons (reverse row) data)))
           (reverse (cons (reverse (cons (list->string (reverse field)) row)) data))))
      ((char=? char #\newline)
       (if quoted?
           (loop data (cons (reverse (cons char field)) row) '() #f (read-char file-port))
           (loop (cons (reverse (cons (list->string (reverse field)) row)) data) '() '() #f (read-char file-port))))
      ((char=? char separator-char)
       (if quoted?
           (loop data row (cons char field) #t (read-char file-port))
           (loop data (cons (list->string (reverse field)) row) '() #f (read-char file-port))))
      ((char=? char quote-char)
       (if quoted?
           (loop data row field #f (read-char file-port))
           (loop data row field #t (read-char file-port))))
      (else
       (loop data row (cons char field) quoted? (read-char file-port))))))
