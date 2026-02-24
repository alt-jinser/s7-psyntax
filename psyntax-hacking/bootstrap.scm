(load-from-path "./load-psyntax.guile.scm")

(use-modules (ice-9 pretty-print))

(if (file-exists? "./psyntax-7.3.pp.1")
    (delete-file "./psyntax-7.3.pp.1"))

(call-with-input-file "./psyntax-7.3.ss"
  (lambda (in)
    (call-with-output-file "./psyntax-7.3.pp.1"
      (lambda (out)
        (display ";;; psyntax.pp\n" out)
        (display ";;; automatically generated from psyntax.ss\n" out)
        (display (string-append
                  ";;; " (strftime "%c %Z" (localtime (current-time))) "\n") out)
        (display ";;; see copyright notice in psyntax.ss\n" out)
        (display "\n" out)
        (let loop ()
          (let ((sexp (read in)))
            (if (eof-object? sexp)
                #f
                (begin
                  (pretty-print (sc-expand sexp #f '(L C) '(L))
                                out)
                  (display "\n" out)
                  (loop)))))))))

