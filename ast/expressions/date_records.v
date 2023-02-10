module expressions

pub struct DateRecordsExpression {
pub:
	values []Expression
}

pub fn (dr DateRecordsExpression) str() string {
	mut output := []string{}

	for value in dr.values {
		output << value.str()
	}

	return output.join('\n')
}
