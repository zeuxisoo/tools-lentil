module statements

pub struct DateStatement {
pub:
	value string
	block Statement
}

pub fn (d DateStatement) ast_str() string {
	mut output := [
		'${d.value} {',
		(d.block as DateBlockStatement).ast_str(),
		'}',
	]

	return output.join('\n')
}
