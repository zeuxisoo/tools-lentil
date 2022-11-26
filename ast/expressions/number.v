module expressions

import ast { Expression }

pub struct NumberExpression {
	kind  Expression
	value string
}

pub fn (n NumberExpression) display() {
	println('TODO: number')
}
