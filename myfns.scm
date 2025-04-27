; call to start the interpreter
(define (plan program)
	(evalPlanFunc (car (cdr program)) '()) 
)

; decides how to execute each token by checking its type/value
(define (evalPlanFunc program idsTree)
	(cond 
		((integer? program) program)
		((symbol? program) (lookup program idsTree))
		((equal? (car program) 'planIf) (evalPlanIf (cadr program) (caddr program) (cadddr program) idsTree)) ; cadr is 1st item and if its 2 d's then its 2nd item
		((equal? (car program) 'planAdd) (evalPlanAdd (cadr program) (caddr program) idsTree))
		((equal? (car program) 'planMul) (evalPlanMul (cadr program) (caddr program) idsTree))
		((equal? (car program) 'planSub) (evalPlanSub (cadr program) (caddr program) idsTree))
		((equal? (car program) 'planLet) (evalPlanLetExpr (cadr program) (caddr program) (cadddr program) idsTree))
		((equal? (car program) 'planFunction) program)
		(else (evalPlanLetFunc (car program) (cadr program) idsTree)) ; func, arguments, idsTree
	)
)

; if condition is greater than 0, returns body1, else returns body2
(define (evalPlanIf condition body1 body2 idsTree) 
	(cond ((> (evalPlanFunc condition idsTree) 0) (evalPlanFunc body1 idsTree))
		(else (evalPlanFunc body2 idsTree))
	)
)

; adds formal param a to formal param b after evaluating their value since they may be a variable, expression or integer
(define (evalPlanAdd a b idsTree)
	(+ (evalPlanFunc a idsTree) (evalPlanFunc b idsTree))
)

; multiplies formal param a with formal param b after evaluating their value since they may be a variable, expression or integer
(define (evalPlanMul a b idsTree)
	(* (evalPlanFunc a idsTree) (evalPlanFunc b idsTree))
)

; subtracts formal param a with formal param b after evaluating their value since they may be a variable, expression or integer
(define (evalPlanSub a b idsTree)
	(- (evalPlanFunc a idsTree) (evalPlanFunc b idsTree))
)

; creates idsTree that grows to the left and contains the id as the left child and the corresponding value as the right child
(define (evalPlanLetExpr id a b idsTree)
	(evalPlanFunc b (cons (cons id (evalPlanFunc a idsTree)) idsTree))
)
	
; recursively searches through the left of the idsTree to find value of the formal param id
(define (lookup id idsTree)
	(cond
		((equal? (caar idsTree) id) (cdar idsTree))
		(else (lookup id (cdr idsTree)))
	)
)

; creates formal param with its corresponding argument value for func
(define (evalPlanLetFunc func a idsTree)
	(evalPlanFunc (caddr (lookup func idsTree)) (cons (cons (cadr (lookup func idsTree)) a) idsTree)) 
)