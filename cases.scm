;; Test Cases for the project

; Use this file for testing individial cases from within the scheme interpreter
; Start the interpter then load this file using the command 
;  ,load cases.scm 
; or the command
;  (load "cases.scm")
; After loading, you can test your interpeter using this command:
;  (test n)
; Where n is some value 1-10



; regular project cases
(define c1 '(planProg 10))
(define c2 '(planProg (planAdd 1 2)))
(define c3 '(planProg (planMul 2 5)))
(define c4 '(planProg (planSub 0 10)))
(define c5 '(planProg (planIf 0 5 10)))
(define c6 '(planProg (planLet x 10 (planAdd x x))))
(define c7 '(planProg (planAdd 10 (planLet x 5 (planMul x x)))))
(define c8 '(planProg (planLet x (planSub 0 (planLet x 10 x)) (planAdd x (planLet x 1 (planAdd x x))))))
(define c9 '(planProg (planLet x (planSub 0 (planAdd 10 11)) (planLet y x (planMul x y)))))
(define c10 '(planProg (planIf (planAdd 0 1) (planLet x 10 x) (planLet x 15 x))))

; EXTRA CREDIT cases
(define c11 '(planProg (planLet a (planFunction b (planAdd b b)) (a 5))))
(define c12 '(planProg (planLet a (planFunction b (planAdd b b)) (planLet a 1 (planMul a a)))))
(define c13 '(planProg (planLet a (planFunction b (planAdd b b)) (planAdd (a 5) (a 5)))))
(define c14 '(planProg (planLet a (planFunction b (planAdd b b)) (planLet a (planFunction b (planMul b b)) (a 5)))))

; regular project expected values 
(define e1 10)
(define e2 3)
(define e3 10)
(define e4 -10)
(define e5 10)
(define e6 20)
(define e7 35)
(define e8 -8)
(define e9 441)
(define e10 10)

; EXTRA CREDIT expected values
(define e11 10)
(define e12 1)
(define e13 20)
(define e14 25)





(define (test x) 
	(load "myfns.scm")
	(display 
		(string-append 
			"Expected:\n" 
			(number->string 
				(eval 
					(string->symbol 
						(string-append 
							"e" 
							(number->string x)
						)
					)
					(interaction-environment)
				)
			) 
			"\nYour output:\n"
		)
	) 
	(plan 
		(eval
			(string->symbol (string-append "c" (number->string x)))
			(interaction-environment)
		)
	)
)