module statements

import ast.expressions { Expression, AssignExpression }

pub struct ExpressionStatement {
pub:
	expression Expression
}

pub fn (e ExpressionStatement) ast() string {
	return match e.expression {
		AssignExpression {
			e.expression.ast()
		}
		else {
			// skip other expression
			""
		}
	}
}
