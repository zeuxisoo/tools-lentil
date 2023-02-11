module expressions

pub struct DateRecordReceiptExpression {
pub:
	account Expression
	amounts Expression
pub mut:
	is_last bool
}

pub fn (dr DateRecordReceiptExpression) ast_str() string {
	return [
		(dr.account as IdentifierExpression).ast_str(),
		(dr.amounts as AmountsExpression).ast_str(),
	].join('')
}
