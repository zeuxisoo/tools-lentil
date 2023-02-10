module statements

pub struct DateStatement {
pub:
	value string
	block Statement
}

pub fn (d DateStatement) str() string {
	mut output := [
		'${d.value} {',
		d.block.str(),
		'}',
	]

	return output.join('\n')
}
