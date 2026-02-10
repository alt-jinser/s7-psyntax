(module T (no_access)
  (define no_access #t))

(module B (b)
  (import T) ; FIXME
  (define b #t))

(module C ()
  (import B)
  (display no_access) ; print #t
  (display b))        ; unbound variable b
