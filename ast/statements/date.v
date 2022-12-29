module statements

import ast { Statement }

pub struct DateStatement {
	value string
	block Statement
}

pub fn (ds DateStatement) display() {
	println('TODO: date statement')
}
