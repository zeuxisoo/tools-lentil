module parser

import ast.expressions { Expression, IdentifierExpression }

pub fn parse_identifier_expression(mut p Parser) !Expression {
	if p.look_next_token().kind == .assign {
		return parse_assign_expression(mut p)!
	}

	identifier := IdentifierExpression{
		value: p.current_token.value
	}

	return identifier
}
