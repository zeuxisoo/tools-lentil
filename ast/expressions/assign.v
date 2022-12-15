module expressions

import ast { Expression }

pub struct AssignExpression {
pub:
	left  Expression
	right Expression
}

pub fn (s AssignExpression) display() {
	println('TODO: assign')
}
