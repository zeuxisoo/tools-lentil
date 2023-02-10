module expressions

pub struct DateRecordReceiptExpression {
pub:
	account Expression
	amounts Expression
pub mut:
	is_last bool
}

pub fn (dr DateRecordReceiptExpression) str() string {
	return [
		dr.account.str(),
		dr.amounts.str(),
	].join('')
}
