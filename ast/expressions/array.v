module expressions

import ast { Expression }

pub struct ArrayExpression {
pub:
	values []Expression
}

pub fn (a ArrayExpression) str() string {
	return 'TODO: array'
}
