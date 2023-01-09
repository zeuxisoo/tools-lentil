module statements

import ast { Statement }

pub struct DateStatement {
pub:
	value string
	block Statement
}

pub fn (ds DateStatement) str() string {
	mut output := [
		'${ds.value} {',
		ds.block.str(),
		'}',
	]

	return output.join('\n')
}
