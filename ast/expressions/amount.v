module expressions

pub struct AmountExpression {
pub:
	value    Expression
	currency Expression
}

pub fn (a AmountExpression) ast() string {
	return [
		(a.value as NumberExpression).ast(),
		(a.currency as IdentifierExpression).ast(),
	].join('')
}
