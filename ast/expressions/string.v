module expressions

pub struct StringExpression {
pub mut:
	value string
}

pub fn (s StringExpression) ast() string {
	return s.value
}
