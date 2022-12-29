module statements

import ast { Statement }

pub struct DateStatement {
pub:
	value string
	block Statement
}

pub fn (ds DateStatement) display() {
	println('TODO: date statement')
}
