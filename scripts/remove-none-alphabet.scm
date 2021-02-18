; do one single design
; in-text-position is one of: 'top 'bottom 'left 'right
(define (remove-none-alphabet in-string font-size font-name font-color)

  (define (replace-chars the-list result)
    (if (equal? '() the-list)
        (apply string (reverse result))
        (replace-chars (cdr the-list)
                       (if (re-match "[A-z]" (string (car the-list)))
                           (cons (car the-list) result)
                           result))))

  (let* ((out-string (replace-chars (string->list in-string) '()))
        (the-image (car (gimp-image-new
                         200 ;width
                         150 ;height
                         RGB)))
        (the-layer (car (gimp-layer-new the-image
                                         200 ;width
                                         150 ;height
                                         RGBA-IMAGE
                                         "bg Layer"
                                         100
                                         0))))
    (gimp-context-set-foreground font-color)
    (gimp-text-fontname
        the-image -1
        10 ;x
        70 ;y
        out-string
        0; border
        TRUE
        font-size PIXELS
        font-name)

    (gimp-display-new the-image)
    (gimp-displays-flush)
    (gimp-image-clean-all the-image)))
    

; make the GUI
(script-fu-register
 "remove-none-alphabet"                               ;func name
 "Remove None Alphabet"                         ;menu label
 "removes any none \
alphabet characters \
using regex and adds to image"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "February, 2021"                              ;date created
 ""                                            ;image type that the script works on

 ; the GUI
 ;type         ;label                        ;values
 SF-STRING     "Input string"                "l33t hax0r ;-)"
 SF-ADJUSTMENT "Font Size"                   '(12 0 1000 1 10 0 1)
 SF-FONT       "Font Name"                   "Sans"    ;a font variable
 SF-COLOR      "Font Color"                  '(0 0 0))


; register the menu
(script-fu-menu-register "remove-none-alphabet" "<Image>/Script-Fu/Examples")
