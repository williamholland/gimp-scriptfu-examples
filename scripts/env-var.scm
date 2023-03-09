; get the filepath for ~/Untitled.jpg
(define (my-gimp-image-get-filename)
  (string-append (getenv "HOME") "/Untitled.jpg"))


; main function of this plugin, duplicate the image, scale and save
(define (save-scaled-duplicate the-image)

  (gimp-message "in save-scaled-duplicate")

  (let* ((the-duplicate-image (car (gimp-image-duplicate the-image)))
         (the-output-path (my-gimp-image-get-filename)))

    ; merge all the layers otherwise it will only do 1 layer
    (gimp-image-merge-visible-layers the-duplicate-image 0)

    ;scale image to 200x200
    (gimp-image-scale the-duplicate-image
                      200
                      200)

    (gimp-message "saving to")
    (gimp-message the-output-path)

    ; save to jpg
    (file-jpeg-save RUN-NONINTERACTIVE
                    the-duplicate-image
                    (car (gimp-image-get-active-drawable the-duplicate-image))
                    the-output-path
                    the-output-path
                    0.9 ;quality
                    0.0 ;smoothing
                    1   ;optimize
                    1   ;progressive
                    ""  ;comment
                    2   ;subsampling
                    0   ;baseline
                    0   ;restart
                    0   ;DCT
                    )

    (gimp-image-delete the-duplicate-image)))


(define (script-fu-scaled-jpeg-home the-image the-drawable)
  (gimp-message "in script-fu-scaled-jpeg-home")
    (save-scaled-duplicate the-image))


; register the plugin
(script-fu-register
 "script-fu-scaled-jpeg-home"                      ;func name
 "Create Scaled JPEG in home dir"                  ;menu label
 "output scaled version of this image to home"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "March, 2023"                                 ;date created
 ""                                            ;image type that the script works on

 ; define the GUI
 ;type         ;label                        ;values
 SF-IMAGE    "Image"         0
 SF-DRAWABLE "Layer"         0)


; register the menu
(script-fu-menu-register "script-fu-scaled-jpeg-home" "<Image>/Scripts")
