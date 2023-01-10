module statements

import ast { Expression }

pub struct DateBlockStatement {
pub:
	value Expression
}

pub fn (db DateBlockStatement) str() string {
	return db.value.str()
}
