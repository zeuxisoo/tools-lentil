module expressions

pub struct AccountExpression {
pub mut:
	value string
mut:
	kind string
}

pub fn (a AccountExpression) ast_str() string {
	return '${a.value} (${a.kind})'
}
