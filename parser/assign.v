module parser

import ast.expressions { Expression, AssignExpression, IdentifierExpression }

pub fn parse_assign_expression(mut parser Parser) !Expression {
	identifier := IdentifierExpression{
		value: parser.current_token.value
	}

	parser.read_token() // skip identifier
	parser.read_token() // skip `=`

	return AssignExpression{
		left: identifier
		right: parser.parse_expression()!
	}
}
