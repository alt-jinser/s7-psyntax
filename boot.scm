(define (void) (if #f #f))

(define (andmap f first . rest)
  (if (null? rest)
      (let andmap ((first first))
        (if (null? first)
            #t
            (let ((x (car first))
                  (rest (cdr first)))
              (if (null? rest)
                  (f x)
                  (and (f x) (andmap rest))))))
      (let andmap ((first first) (rest rest))
        (if (null? first)
            #t
            (let ((x (car first))
                  (xr (map car rest))
                  (next-first (cdr first))
                  (next-rest (map cdr rest)))
              (if (null? next-first)
                  (apply f (cons x xr))
                  (and (apply f (cons x xr))
                       (andmap next-first next-rest))))))))

(define (ormap f list1)
  (and (not (null? list1))
       (or (f (car list1))
           (ormap f (cdr list1)))))

(define *symbol-properties* (make-hash-table))

(define (putprop symbol key value)
  (let ((props (hash-table-ref *symbol-properties* symbol)))
    (if props
        (hash-table-set! props key value)
        (let ((new-props (make-hash-table)))
          (hash-table-set! new-props key value)
          (hash-table-set! *symbol-properties* symbol new-props)))
    value))

(define (getprop symbol key)
  (let ((props (hash-table-ref *symbol-properties* symbol)))
    (if props
        (hash-table-ref props key)
        #f)))

(define (remprop symbol key)
  (let ((props (hash-table-ref *symbol-properties* symbol)))
    (if props
        (hash-table-set! props key #f))
    #f))

(define s7-gensym gensym)
(define (gensym x)
  (cond
    ((symbol? x) (s7-gensym (symbol->string x)))
    (else        (s7-gensym x))))


;; API provided by psyntax
(define $sc-put-cte             #f)
(define sc-expand               #f)
(define $make-environment       #f)
(define environment?            #f)
(define interaction-environment #f)
(define identifier?             #f)
(define unwrap-syntax           #f)
(define syntax->list            #f)
(define syntax-object->datum    #f)
(define datum->syntax-object    #f)
(define generate-temporaries    #f)
(define free-identifier=?       #f)
(define bound-identifier=?      #f)
(define literal-identifier=?    #f)
(define syntax-error            #f)
(define $syntax-dispatch        #f)

(define syntax->vector          #f)

(set! (*s7* 'symbol-quote?) #t)

(define %primitive-eval eval)
(define %primitive-load load)

(define (eval expr . env)
  (let ((target-env (if (pair? env) (car env) (rootlet))))
    (if (and (pair? expr)
             (equal? (car expr) "noexpand"))
        (%primitive-eval (cadr expr) target-env)
        (%primitive-eval expr target-env))))

; (load "psyntax.pp")
(load "readevalprintloop-psyntax-7.3.pp")





(define (load filename)
  (if (file-exists? filename)
      (let ((forms '()))
        (with-input-from-file filename
          (lambda ()
            (let loop ((expr (read)))
              (if (eof-object? expr)
                  (begin
                    (let ((expanded (sc-expand `(begin ,@(reverse forms)) #f '(L C) '(L))))
                      (display "--- ") (display `(begin ,@(reverse forms))) (newline)
                      (display "... ") (display expanded) (newline)
                      (eval expanded)))
                  (begin
                    (set! forms (cons expr forms))
                    (loop (read))))))))
      (error 'load (string-append "file not found: " filename))))

(load "x.scm")

; (load "psyntax.ss")
