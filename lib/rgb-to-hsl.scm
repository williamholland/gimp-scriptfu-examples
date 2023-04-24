(define (radians->degrees n)
  (let ((pi (acos -1)))
    (* n (/ 180 pi))))
	
(define (degrees->radians n)
  (let ((pi (acos -1)))
    (* n (/ pi 180))))
	
(define (rgb->hsl rgb-list)
  (let* ((R (list-ref rgb-list 0)) (G (list-ref rgb-list 1)) (B (list-ref rgb-list 2))
		 (pi (acos -1))
		 (M (apply max rgb-list))
         (m (apply min rgb-list))
		 (d (/ (- M m) 255))
		 (L (/ (+ M m) 510)))
    (if (= R G B) (list 0 0 L)
	(list 
		;Hue
		(radians->degrees (if (>= G B)
		  (acos (/ (- R (/ G 2) (/ B 2))
		           (sqrt (+ (* R R) (* G G) (- (* B B) (* R G) (* R B) (* G B))))))
		  (- (* 2 pi) (acos (/ (- R (/ G 2) (/ B 2))
		           (sqrt (+ (* R R) (* G G) (- (* B B) (* R G) (* R B) (* G B)))))))))
		;Saturation
		(if (= L 0) 0
		            (/ d
					   (- 1 (abs (- (* 2 L) 1)))))
		;Lightness
		L))))
