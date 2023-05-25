; determine if id given refers to image or drawable
(define (id-is-image? id)
  (member id (vector->list (cadr (gimp-image-list)))))

; find the child drawable by name where parent is the image ID or a group
(define (find-drawable-by-name parent name)
  (define (find-drawable-by-name-inner drawables)
    (cond ((eqv? drawables '())
             (gimp-message (string-append "Could not find layer: " name)))
  		((string=? name (car (gimp-drawable-get-name (car drawables))))
  			(car drawables))
  		(else (find-drawable-by-name-inner (cdr drawables)))))

  (find-drawable-by-name-inner
    (if (id-is-image? parent)
      (vector->list (cadr (gimp-image-get-layers parent)))   
      (vector->list (cadr (gimp-item-get-children parent))))))
