module statements

import ast { Expression }

pub struct ExpressionStatement {
	expression Expression
}

pub fn (es ExpressionStatement) display() {
	println('TODO: expression statement')
}
