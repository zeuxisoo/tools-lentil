module expressions

import ast { Expression }

pub struct DateRecordReceiptExpression {
	amounts Expression
pub:
	account Expression
pub mut:
	is_last bool
}

pub fn (dr DateRecordReceiptExpression) display() {
	println('TODO: date record receipt')
}
