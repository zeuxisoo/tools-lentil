module expressions

pub struct DateRecordsExpression {
pub:
	values []Expression
}

pub fn (dr DateRecordsExpression) ast_str() string {
	mut output := []string{}

	for value in dr.values {
		output << (value as DateRecordExpression).ast_str()
	}

	return output.join('\n')
}
