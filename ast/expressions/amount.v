module expressions

import ast { Expression }

pub struct AmountExpression {
	value    Expression
	currency Expression
}

pub fn (a AmountExpression) display() {
	println('TODO: amount')
}
