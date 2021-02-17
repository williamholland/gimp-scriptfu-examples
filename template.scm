; do one single design
; in-text-position is one of: 'top 'bottom 'left 'right
(define (some-function GUI options...)

; make the GUI
(script-fu-register
 "some-function"                               ;func name
 "Script Fu Name Here"                         ;menu label
 "does a thing"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "February, 2021"                              ;date created
 ""                                            ;image type that the script works on

 ; the GUI
 ;type         ;label                        ;values
 SF-OPTION     "Use a single phrase or list" '("this" "that"))


: register the menu
(script-fu-menu-register "some-function" "<Image>/File/Create/Design")
