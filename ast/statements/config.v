module statements

import ast { Statement }

pub struct ConfigStatement {
pub:
	block Statement
}

pub fn (c ConfigStatement) str() string {
	return 'TODO: config'
}
