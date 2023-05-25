; this script contains some useful input functions:

; 1) read-line - read one line from a file-port
; 2) read-lines - read all the lines from a file-port into a list
; 3) read-csv-line - read one line of a csv from a fileport and return a list
; 3) read-csv - read a CSV into a list of lists

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

(define (script-fu-read-first-line filename)
  (let* ((file (open-input-file filename))
         (lines (read-lines file)))
    (close-input-port file)
    (gimp-message lines)))

(script-fu-register
 "script-fu-read-first-line"
 "Read First Line"
 "Reads the first line from a text file and displays it in GIMP message"
 "Will Holland"
 ""
 "2023"
 ""

 ; define the GUI
 ;type       ;label              ;values
 SF-FILENAME "Text file" "")

(script-fu-menu-register
 "script-fu-read-first-line"
 "<Image>/Plugins")
