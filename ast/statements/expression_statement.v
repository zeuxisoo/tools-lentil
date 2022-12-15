module statements

import ast { Expression }

pub struct ExpressionStatement {
pub:
	expression Expression
}

pub fn (es ExpressionStatement) display() {
	println('TODO: expression statement')
}
