module expressions

import ast { Expression }

pub struct AmountsExpression {
pub:
	values []Expression
}

pub fn (a AmountsExpression) str() string {
	mut output := []string{}

	for value in a.values {
		output << value.str()
	}

	return output.join(',')
}
