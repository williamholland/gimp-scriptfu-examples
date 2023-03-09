; example to show how re-match can capture strings
(define (re-find-group regexp input-string)
  (define buffer (vector ""))
  (re-match regexp input-string buffer)
  (let ((b (vector-ref buffer 0)))
    (substring input-string (car b) (cdr b))))

(define (script-fu-regex-example the-image the-drawable)
  (gimp-message (re-find-group "([a-z]*)$" "hello world")))

; register the plugin
(script-fu-register
 "script-fu-regex-example"                      ;func name
 "regex example"                       ;menu label
 "regex example"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "March, 2023"                                 ;date created
 ""                                            ;image type that the script works on

 ; define the GUI
 ;type         ;label                        ;values
 SF-IMAGE    "Image"         0
 SF-DRAWABLE "Layer to tint" 0
 )


; register the menu
(script-fu-menu-register "script-fu-regex-example" "<Image>/Scripts")
