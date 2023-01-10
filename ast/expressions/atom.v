module expressions

pub struct AtomExpression {
pub:
	value string
}

pub fn (t AtomExpression) str() string {
	return t.value
}
