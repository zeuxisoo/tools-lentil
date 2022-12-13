module statements

import ast { Expression }

pub struct IncludeStatement {
pub mut:
	path Expression
}

pub fn (i IncludeStatement) display() {
	println('TODO: include')
}
