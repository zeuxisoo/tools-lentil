module statements

pub struct DateStatement {
pub:
	value string
	block Statement
}

pub fn (d DateStatement) ast() string {
	mut output := [
		'${d.value} {',
		(d.block as DateBlockStatement).ast(),
		'}',
	]

	return output.join('\n')
}
