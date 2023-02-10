module expressions

pub struct NumberExpression {
pub:
	kind  Expression
	value string
}

pub fn (n NumberExpression) ast() string {
	return [
		(n.kind as NumberKindExpression).ast(),
		n.value,
	].join('')
}
