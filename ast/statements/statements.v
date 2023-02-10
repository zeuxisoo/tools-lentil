module statements

pub type Statement = Program
	| ConfigStatement
	| ConfigBlockStatement
	| DateStatement
	| DateBlockStatement
	| ExpressionStatement
	| IncludeStatement
