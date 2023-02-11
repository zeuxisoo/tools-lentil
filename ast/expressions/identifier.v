module expressions

pub struct IdentifierExpression {
pub:
	value string
}

pub fn (s IdentifierExpression) ast_str() string {
	return s.value
}
