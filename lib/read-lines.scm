; this script contains some useful input functions:

; 1) read-line - read one line from a file-port
; 2) read-lines - read all the lines from a file-port into a list

(define (read-line file-port)
  (let loop ((line '()))
    (let ((char (read-char file-port)))
      (cond
        ((or (eof-object? char) (char=? char #\newline))
         (list->string (reverse line))) ; Convert the list of characters to a string
        (else
         (loop (cons char line)))))))

(define (read-lines file-port)
  (let loop ((lines '())
             (line (read-line file-port)))
    (if (eof-object? line)
        (reverse lines) ; Reverse the list of lines before returning
        (loop (cons line lines) (read-line file-port)))))
