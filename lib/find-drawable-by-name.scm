(define (find-drawable-by-name image name)
  (define (find-drawable-by-name-inner drawables)
    (cond ((eqv? drawables '())
             (gimp-message (string-append "Could not find layer: " name)))
  		((string=? name (car (gimp-drawable-get-name (car drawables))))
  			(car drawables))
  		(else (find-drawable-by-name-inner (cdr drawables)))))
  (find-drawable-by-name-inner (vector->list (cadr (gimp-image-get-layers image))) name))