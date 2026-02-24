```shell
> ./guile-boot.sh; s7 boot.scm
load boot.scm
orig-before: #(syntax-object (import T) ((#f top) shift #(ribcage () () ()) #(top-ribcage *top* #t)))
ENTERING $IMPORT-HELP
orig-after: #(syntax-object (import T) ((#f top) shift #(ribcage () () ()) #(top-ribcage *top* #t)))
orig-pass: #(syntax-object (import T) ((#f top) shift #(ribcage () () ()) #(top-ribcage *top* #t)))
orig-in-case: #(syntax-object (import T) ((#f top) shift #(ribcage () () ()) #(top-ribcage *top* #t)))
counter: 0

orig-before: #(syntax-object (import B) ((#f top) shift #(ribcage () () ()) #(top-ribcage *top* #t)))
ENTERING $IMPORT-HELP
orig-after: #(syntax-object (import B) ((#f top) shift #(ribcage () () ()) #(top-ribcage *top* #t)))
orig-pass: #(syntax-object (import B) ((#f top) shift #(ribcage () () ()) #(top-ribcage *top* #t)))
orig-in-case: #(syntax-object (import T) ((#f top) shift #(ribcage (b no_access) ((top) (top)) (#(indirect-label _2) _0)) #(top-ribcage *top* #t)))
counter: 1

(begin (begin (define _0 (void)) (letrec (({_0}-0 (quote #t))) (begin (set! _0 {_0}-0) (void)))) (begin (define _2 (void)) (letrec (({_2}-1 (quote #t))) (begin (set! _2 {_2}-1) (void)))) (begin (display _0) (display b) (void)))
#t


;'b is unbound in (display b) (*stdout*[12])
;  boot.scm[129]
(display b)
((void))
```
