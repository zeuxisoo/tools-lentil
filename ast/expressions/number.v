module expressions

pub struct NumberExpression {
pub:
	kind  Expression
	value string
}

pub fn (n NumberExpression) str() string {
	return [
		n.kind.str(),
		n.value,
	].join('')
}
