module expressions

pub struct AccountExpression {
pub mut:
	value string
mut:
	kind string
}

pub fn (a AccountExpression) ast() string {
	return '${a.value} (${a.kind})'
}
