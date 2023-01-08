module expressions

pub struct StringExpression {
pub mut:
	value string
}

pub fn (s StringExpression) str() string {
	return s.value
}
