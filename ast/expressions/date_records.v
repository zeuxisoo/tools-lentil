module expressions

pub struct DateRecordsExpression {
pub:
	values []Expression
}

pub fn (dr DateRecordsExpression) ast() string {
	mut output := []string{}

	for value in dr.values {
		output << (value as DateRecordExpression).ast()
	}

	return output.join('\n')
}
