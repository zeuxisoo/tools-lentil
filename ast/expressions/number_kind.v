module expressions

pub struct NumberKindExpression {
pub:
	value string
}

pub fn (n NumberKindExpression) ast_str() string {
	return n.value
}
