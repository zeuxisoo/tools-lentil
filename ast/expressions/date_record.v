module expressions

import ast { Expression }

pub struct DateRecordExpression {
pub:
	values      []Expression
	title       Expression
	description Expression
}

pub fn (dr DateRecordExpression) str() string {
	mut output_table := []string{}
	mut output_row := []string{}

	for value in dr.values {
		output_row << value.str()
	}

	title := dr.title.str()
	description := dr.description.str()

	if title.len > 0 {
		output_row << ':${title}'
	}

	if description.len > 0 {
		output_row << ':${description}'
	}

	output_table << output_row.join(' ')

	return output_table.join('\n')
}
