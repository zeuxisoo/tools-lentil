module statements

import ast { Statement }

pub struct ConfigBlockStatement {
	values []Statement
}

pub fn (cb ConfigBlockStatement) display() {
	println('TODO: config block')
}
