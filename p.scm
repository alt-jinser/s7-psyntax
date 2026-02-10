(define generate-id
  (let ((digits "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!$%&*/:<=>?~_^.+-"))
    (let ((base (string-length digits)) (session-key "_"))
      (define make-digit (lambda (x) (string-ref digits x)))
      (define fmt
        (lambda (n)
          (let fmt ((n n) (a '()))
            (if (< n base)
                (list->string (cons (make-digit n) a))
                (let ((r (modulo n base)) (rest (quotient n base)))
                  (fmt rest (cons (make-digit r) a)))))))
      (let ((n -1))
        (lambda (name) ; name is #f or a symbol
          (set! n (+ n 1))
          (string->symbol (string-append session-key (fmt n))))))))

(display (generate-id #f)) (newline)
(display (generate-id #f)) (newline)
(display (generate-id #f)) (newline)
(display (generate-id #f)) (newline)
(display (generate-id #f)) (newline)
(display (generate-id #f)) (newline)
(display (generate-id #f)) (newline)
(display (generate-id #f)) (newline)
