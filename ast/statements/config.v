module statements

pub struct ConfigStatement {
pub:
	block Statement
}

pub fn (c ConfigStatement) ast_str() string {
	mut output := [
		'config {',
		(c.block as ConfigBlockStatement).ast_str()
		'}'
	]

	return output.join('\n')
}
