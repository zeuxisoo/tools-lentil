module expressions

import ast { Expression }

pub struct DateRecordReceiptExpression {
pub:
	account Expression
	amounts Expression
pub mut:
	is_last bool
}

pub fn (dr DateRecordReceiptExpression) str() string {
	return 'TODO: date record receipt'
}
