module expressions

pub struct AmountExpression {
pub:
	value    Expression
	currency Expression
}

pub fn (a AmountExpression) ast_str() string {
	return [
		(a.value as NumberExpression).ast_str(),
		(a.currency as IdentifierExpression).ast_str(),
	].join('')
}
