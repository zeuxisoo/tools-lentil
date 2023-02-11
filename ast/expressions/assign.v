module expressions

pub struct AssignExpression {
pub:
	left  Expression
	right Expression
}

pub fn (s AssignExpression) ast_str() string {
	left := (s.left as IdentifierExpression).ast_str()
	right := match s.right {
		IdentifierExpression {
			s.right.ast_str()
		}
		ArrayExpression {
			s.right.ast_str()
		}
		AccountExpression{
			s.right.ast_str()
		}
		else{
			// skip other expression
			""
		}
	}

	return '${left} = ${right}'
}
