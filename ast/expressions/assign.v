module expressions

pub struct AssignExpression {
pub:
	left  Expression
	right Expression
}

pub fn (s AssignExpression) ast() string {
	left := (s.left as IdentifierExpression).ast()
	right := match s.right {
		IdentifierExpression {
			s.right.ast()
		}
		ArrayExpression {
			s.right.ast()
		}
		AccountExpression{
			s.right.ast()
		}
		else{
			// skip other expression
			""
		}
	}

	return '${left} = ${right}'
}
