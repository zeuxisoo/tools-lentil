module statements

import ast.expressions { Expression }

pub struct ExpressionStatement {
pub:
	expression Expression
}

pub fn (e ExpressionStatement) str() string {
	return e.expression.str()
}
