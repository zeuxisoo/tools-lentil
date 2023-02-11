module expressions

pub struct AtomExpression {
pub:
	value string
}

pub fn (t AtomExpression) ast_str() string {
	return t.value
}
