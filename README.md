```shell
s7 boot.scm
```

### Module Bug

```scheme
(module T (no_access)
  (define no_access #t))

(module B (b)
  (import T) ; FIXME
  (define b #t))

(module C ()
  (import B)
  (display no_access) ; print #t
  (display b))        ; unbound variable b
```

只要 module 有 `(import)`，那么其自身的符号就会被覆盖。例如这里的 b 访问不到，而 no_access 可以。
这显然不是预期的，这导致代码库无法被正确引导。

### (E), (E)
```scheme
(begin (begin (define _0 (void))
              (letrec (({_0}-0 (quote #t)))
                (begin
                  (set! _0 {_0}-0) (void))))

       (begin (define _2 (void))
              (letrec (({_2}-1 (quote #t)))
                (begin
                  (set! _2 {_2}-1) (void))))

       (begin (display _0)
              (display b)
              (void)))
```


### (L C), (L)
```scheme
(begin (begin
         ($sc-put-cte (quote #(syntax-object T ((top) #(ribcage #(T) #((top)) #(T)))))
                      (quote ($module . #(interface (top) #(#(syntax-object no_access ((top) #(ribcage #(no_access) #((top)) #(_0))))) _1)))
                      (quote *top*)
              (begin (define _0 (void))
                     (letrec (({_0}-0 (quote #t)))
                       (begin
                         (set! _0 {_0}-0) (void))))))

       (begin ($sc-put-cte (quote #(syntax-object B ((top) #(ribcage #(B) #((top)) #(B)))))
                           (quote ($module . #(interface (top) #(#(syntax-object b ((top) #(ribcage #(b) #((top)) #(_2))))) _3)))
                           (quote *top*))
              (begin (define _0 (void))
                     (letrec (({_0}-1 (quote #t)))
                       (begin
                         (set! _0 {_0}-1) (void)))))

       (begin ($sc-put-cte (quote #(syntax-object C ((top) #(ribcage #(C) #((top)) #(C)))))
                           (quote ($module . #(interface (top) #() _4)))
                           (quote *top*))
              (begin (define _0 (void))
                     (letrec (({_0}-2 (quote #t)))
                       (begin
                         (set! _0 {_0}-2) (void))))))
```

### refs

https://codeberg.org/readevalprintloop/psyntax-hacking
