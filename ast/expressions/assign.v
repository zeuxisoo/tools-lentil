module expressions

import ast { Expression }

pub struct AssignExpression {
pub:
	left  Expression
	right Expression
}

pub fn (s AssignExpression) str() string {
	return 'TODO: assign'
}
