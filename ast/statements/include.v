module statements

import ast.expressions { Expression, StringExpression }

pub struct IncludeStatement {
pub mut:
	path Expression
}

pub fn (i IncludeStatement) ast_str() string {
	path := (i.path as StringExpression).ast_str()

	return 'include "${path}"'
}
