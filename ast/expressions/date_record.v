module expressions

pub struct DateRecordExpression {
pub:
	values      []Expression
	title       Expression
	description Expression
}

pub fn (dr DateRecordExpression) ast_str() string {
	mut output_table := []string{}
	mut output_row := []string{}

	for value in dr.values {
		output_row << (value as DateRecordReceiptExpression).ast_str()
	}

	title := (dr.title as AtomExpression).ast_str()
	description := (dr.description as AtomExpression).ast_str()

	if title.len > 0 {
		output_row << ':${title}'
	}

	if description.len > 0 {
		output_row << ':${description}'
	}

	output_table << output_row.join(' ')

	return output_table.join('\n')
}
