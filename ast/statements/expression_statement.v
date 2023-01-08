module statements

import ast { Expression }

pub struct ExpressionStatement {
pub:
	expression Expression
}

pub fn (es ExpressionStatement) str() string {
	return es.expression.str()
}
