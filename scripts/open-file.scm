
(define (scriptfu-open-file in-file)
  
  (let ((the-image
         (car (gimp-file-load RUN-NONINTERACTIVE in-file in-file))))

    (gimp-display-new the-image) ; show the image in a tab
    (gimp-displays-flush) ; update what you see in the GUI
    (gimp-image-clean-all the-image) ; make it so won't be asked if you want to save changes when closing
    ))


(script-fu-register
 "scriptfu-open-file"                          ;func name
 "Script Fu Open File"                         ;menu label
 "open a file into a scriptfu"
 "Will Holland"                                ;author
 ""                                            ;copyright notice
 "February, 2021"                              ;date created
 ""                                            ;image type that the script works on

 ;GUI element  ;label                          ;default values
 SF-FILENAME   "File"                          (string-append gimp-data-directory ""))


(script-fu-menu-register "scriptfu-open-file" "<Image>/File/Create/Design")