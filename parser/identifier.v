module parser

import ast { Expression }
import ast.expressions { IdentifierExpression }

pub fn parse_identifier_expression(mut parser Parser) !Expression {
	if parser.look_next_token().kind == .assign {
		return parse_assign_expression(mut parser)!
	}

	identifier := IdentifierExpression{
		value: parser.current_token.value
	}

	return identifier
}
