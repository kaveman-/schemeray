
(define-syntax define-entry-point
  (syntax-rules (init:)
    ((_ (name) (init: init-expr) expr ...)
     (begin
       (define (name argc argv)
         expr ...)
       init-expr))
    ((_ (name) expr ...)
     (define-entry-point (name)
       (init: (lambda () #t))
       expr ...))))

(define (maybe->string thing)
  (if (symbol? thing)
      (symbol->string thing)
      thing))

(define (symbol-append . things)
  (string->symbol
   (apply string-append (map maybe->string
                             things))))

(define (copy-record r)
  (let* ((len (record-length r))
         (copy (make-record len #f)))
    (let loop ((i 0))
      (if (< i len)
          (begin
            (record-set! copy i (record-ref r i))
            (loop (+ i 1)))))
    copy))

(define (change-record-type r type)
  (let ((copy (copy-record r)))
    (record-set! copy 0 type)
    copy))
