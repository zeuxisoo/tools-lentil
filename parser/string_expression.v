module parser

import ast { Expression }
import ast.expressions { StringExpression }

pub fn parse_string_expression(mut p Parser) Expression {
	p.current_token = p.read_token()

	expression := StringExpression{
		value: p.current_token.value
	}

	return expression
}
