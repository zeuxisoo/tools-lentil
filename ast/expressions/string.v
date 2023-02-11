module expressions

pub struct StringExpression {
pub mut:
	value string
}

pub fn (s StringExpression) ast_str() string {
	return s.value
}
