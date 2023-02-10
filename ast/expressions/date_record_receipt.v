module expressions

pub struct DateRecordReceiptExpression {
pub:
	account Expression
	amounts Expression
pub mut:
	is_last bool
}

pub fn (dr DateRecordReceiptExpression) ast() string {
	return [
		(dr.account as IdentifierExpression).ast(),
		(dr.amounts as AmountsExpression).ast(),
	].join('')
}
