module parser

import ast.expressions { Expression, StringExpression }

pub fn parse_string_expression(mut p Parser) !Expression {
	expression := StringExpression{
		value: p.current_token.value
	}

	return expression
}
