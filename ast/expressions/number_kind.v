module expressions

pub struct NumberKindExpression {
pub:
	value string
}

pub fn (n NumberKindExpression) ast() string {
	return n.value
}
