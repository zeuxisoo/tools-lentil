module expressions

pub struct AtomExpression {
pub:
	value string
}

pub fn (t AtomExpression) ast() string {
	return t.value
}
