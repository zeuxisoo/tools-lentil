module statements

import ast.expressions { Expression, StringExpression }

pub struct IncludeStatement {
pub mut:
	path Expression
}

pub fn (i IncludeStatement) ast() string {
	path := (i.path as StringExpression).ast()

	return 'include "${path}"'
}
