module statements

import ast.expressions { Expression }

pub struct IncludeStatement {
pub mut:
	path Expression
}

pub fn (i IncludeStatement) str() string {
	return 'include "${i.path.str()}"'
}
