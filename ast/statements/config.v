module statements

import ast { Statement }

pub struct ConfigStatement {
	block Statement
}

pub fn (c ConfigStatement) display() {
	println('TODO: config')
}
