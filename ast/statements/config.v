module statements

pub struct ConfigStatement {
pub:
	block Statement
}

pub fn (c ConfigStatement) ast() string {
	mut output := [
		'config {',
		(c.block as ConfigBlockStatement).ast()
		'}'
	]

	return output.join('\n')
}
