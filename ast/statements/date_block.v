module statements

import ast.expressions { Expression, DateRecordsExpression }

pub struct DateBlockStatement {
pub:
	value Expression
}

pub fn (db DateBlockStatement) ast() string {
	return (db.value as DateRecordsExpression).ast()
}
