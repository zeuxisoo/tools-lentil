module parser

import ast.expressions { Expression, AssignExpression, IdentifierExpression }

pub fn parse_assign_expression(mut p Parser) !Expression {
	identifier := IdentifierExpression{
		value: p.current_token.value
	}

	p.read_token() // skip identifier
	p.read_token() // skip `=`

	return AssignExpression{
		left: identifier
		right: p.parse_expression()!
	}
}
