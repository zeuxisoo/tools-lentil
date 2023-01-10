module expressions

pub struct NumberKindExpression {
pub:
	value string
}

pub fn (n NumberKindExpression) str() string {
	return n.value
}
