module expressions

pub struct AssignExpression {
pub:
	left  Expression
	right Expression
}

pub fn (s AssignExpression) str() string {
	return '${s.left.str()} = ${s.right.str()}'
}
