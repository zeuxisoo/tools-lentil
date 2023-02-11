module expressions

pub struct AmountsExpression {
pub:
	values []Expression
}

pub fn (a AmountsExpression) ast_str() string {
	mut output := []string{}

	for value in a.values {
		output << (value as AmountExpression).ast_str()
	}

	return output.join(',')
}
