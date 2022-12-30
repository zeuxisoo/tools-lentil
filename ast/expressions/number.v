module expressions

import ast { Expression }

pub struct NumberExpression {
pub:
	kind  Expression
	value string
}

pub fn (n NumberExpression) display() {
	println('TODO: number')
}
