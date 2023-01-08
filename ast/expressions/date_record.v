module expressions

import ast { Expression }

pub struct DateRecordExpression {
pub:
	values      []Expression
	title       Expression
	description Expression
}

pub fn (dr DateRecordExpression) str() string {
	return 'TODO: date record'
}
