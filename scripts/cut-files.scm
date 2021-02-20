; do one single design
; in-text-position is one of: 'top 'bottom 'left 'right
(define (script-fu-cut-images-together first-file second-file)

    (let* ((the-image (car (gimp-file-load RUN-NONINTERACTIVE first-file first-file)))
          (image2-layer (car (gimp-file-load-layer RUN-NONINTERACTIVE the-image second-file))))
      (gimp-image-add-layer the-image image2-layer -1)

      ;(gimp-image-resize-to-layers the-image)
      (gimp-layer-scale image2-layer
                        (car (gimp-image-width the-image))
                        (car (gimp-image-height the-image))
                        FALSE)

      (define half-height (/ (car (gimp-image-height the-image)) 2))
      (define img-width (car (gimp-image-width the-image)))

      (gimp-selection-none the-image)
      (define PI (* 4 (atan 1.0)))
      (define slope 5)
      (define (slope-to-radians x)
        (/ (* x PI) 400))
      (define height-diff (* img-width (sin (slope-to-radians slope))))

      (gimp-image-select-polygon the-image 0 8
                                 (list->vector
                                  (list
                                   0 0
                                   0 half-height
                                   img-width (+ height-diff half-height)
                                   img-width 0)))

      ;TODO I delete half the image but it'd be better to use a mask
      (gimp-edit-clear image2-layer)

      (gimp-selection-none the-image)
      
      (gimp-display-new the-image) ; show the image in a tab
      (gimp-displays-flush) ; update what you see in the GUI
      (gimp-image-clean-all the-image) ; make it so won't be asked if you want to save changes when closing
      ))
  

; make the GUI
(script-fu-register
 "script-fu-cut-images-together"                               ;func name
 "Cut images together"                         ;menu label
 "combine images with\
a diagonal line"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "February, 2021"                              ;date created
 ""                                            ;image type that the script works on

 ; the GUI
 ;type         ;label                        ;values
 SF-FILENAME   "Base image"                 gimp-data-directory
 SF-FILENAME   "Second image"                gimp-data-directory)


; register the menu
(script-fu-menu-register "script-fu-cut-images-together" "<Image>/Script-Fu/Examples")
