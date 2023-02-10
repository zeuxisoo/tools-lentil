module expressions

pub struct DateRecordExpression {
pub:
	values      []Expression
	title       Expression
	description Expression
}

pub fn (dr DateRecordExpression) ast() string {
	mut output_table := []string{}
	mut output_row := []string{}

	for value in dr.values {
		output_row << (value as DateRecordReceiptExpression).ast()
	}

	title := (dr.title as AtomExpression).ast()
	description := (dr.description as AtomExpression).ast()

	if title.len > 0 {
		output_row << ':${title}'
	}

	if description.len > 0 {
		output_row << ':${description}'
	}

	output_table << output_row.join(' ')

	return output_table.join('\n')
}
