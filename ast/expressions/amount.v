module expressions

import ast { Expression }

pub struct AmountExpression {
pub:
	value    Expression
	currency Expression
}

pub fn (a AmountExpression) str() string {
	return [
		a.value.str(),
		a.currency.str(),
	].join('')
}
