module statements

import ast.expressions { Expression, AssignExpression }

pub struct ExpressionStatement {
pub:
	expression Expression
}

pub fn (e ExpressionStatement) ast_str() string {
	return match e.expression {
		AssignExpression {
			e.expression.ast_str()
		}
		else {
			// skip other expression
			""
		}
	}
}
