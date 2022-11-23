module expressions

import ast { Expression }

pub struct DateRecordReceiptExpression {
	account Expression
	amounts Expression
	is_last bool
}

pub fn (dr DateRecordReceiptExpression) display() {
	println('TODO: date record receipt')
}
