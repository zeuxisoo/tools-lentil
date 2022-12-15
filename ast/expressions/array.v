module expressions

import ast { Expression }

pub struct ArrayExpression {
pub:
	values []Expression
}

pub fn (a ArrayExpression) display() {
	println('TODO: array')
}
