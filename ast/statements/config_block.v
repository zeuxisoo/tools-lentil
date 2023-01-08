module statements

import ast { Statement }

pub struct ConfigBlockStatement {
pub:
	values []Statement
}

pub fn (cb ConfigBlockStatement) str() string {
	return 'TODO: config block'
}
