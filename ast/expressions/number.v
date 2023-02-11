module expressions

pub struct NumberExpression {
pub:
	kind  Expression
	value string
}

pub fn (n NumberExpression) ast_str() string {
	return [
		(n.kind as NumberKindExpression).ast_str(),
		n.value,
	].join('')
}
