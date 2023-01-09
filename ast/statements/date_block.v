module statements

import ast { Expression }

pub struct DateBlockStatement {
pub:
	value Expression
}

pub fn (dbs DateBlockStatement) str() string {
	return dbs.value.str()
}
