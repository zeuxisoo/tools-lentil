module statements

import ast { Expression }

pub struct ExpressionStatement {
pub:
	expression Expression
}

pub fn (e ExpressionStatement) str() string {
	return e.expression.str()
}
