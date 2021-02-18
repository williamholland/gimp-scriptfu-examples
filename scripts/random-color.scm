(define (random-color the-image the-drawable)

  (define color (car (gimp-image-pick-color the-image
                                       the-drawable
                                       1 ;x
                                       1 ;y
                                       FALSE
                                       FALSE
                                       1)))

  
  (gimp-selection-none the-image)

  (gimp-context-set-sample-threshold-int 80)

  (gimp-image-select-color the-image
                           0
                           the-drawable
                           color)

  (gimp-colorize the-drawable
                 (- (random 361) 1) ; hue 0-360
                 (- (random 101) 1) ; sat 0-100
                 (- (random 201) 101)) ; lightness -100-100

  (gimp-selection-invert the-image)

  (gimp-colorize the-drawable
                 (- (random 361) 1) ; hue 0-360
                 (- (random 101) 1) ; sat 0-100
                 (- (random 201) 101)) ; lightness -100-100

  (gimp-selection-none the-image)
  
  (gimp-displays-flush)) ; update what you see in the GUI
  ;(gimp-image-clean-all the-image)) ; make it so won't be asked if you want to save changes when closing


; make the GUI
(script-fu-register
 "random-color"                               ;func name
 "Random Color"                         ;menu label
 "randomly tint image"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "February, 2021"                              ;date created
 ""                                            ;image type that the script works on

 ; the GUI
 ;type         ;label                        ;values
 SF-IMAGE    "Image"         0
 SF-DRAWABLE "Layer to tint" 0)


; register the menu
(script-fu-menu-register "random-color" "<Image>/Script-Fu/Color")
