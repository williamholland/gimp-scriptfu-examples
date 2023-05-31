; do one single design
; in-text-position is one of: 'top 'bottom 'left 'right
(define (script-fu-make-coloring-in image drawable)
  (gimp-image-undo-group-start image)
  (plug-in-neon RUN-NONINTERACTIVE
                image
                drawable
                0.3
                100)
  (gimp-drawable-invert drawable TRUE)
  (gimp-drawable-desaturate drawable 0)

  (gimp-image-undo-group-end image)
  (gimp-displays-flush))

; make the GUI
(script-fu-register
 "script-fu-make-coloring-in"                               ;func name
 "Make Coloring In"                         ;menu label
 "turn a colored image into a coloring in activity"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "May, 2023"                              ;date created
 ""                                            ;image type that the script works on

 ; the GUI
 ;type         ;label                        ;values
  SF-IMAGE    "Image"         0
 SF-DRAWABLE "Layer" 0)


; register the menu
(script-fu-menu-register "script-fu-make-coloring-in" "<Image>/Plugins")
