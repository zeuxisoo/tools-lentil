module expressions

import ast { Expression }

pub struct AssignExpression {
	left  Expression
	right Expression
}

pub fn (s AssignExpression) display() {
	println('TODO: assign')
}
