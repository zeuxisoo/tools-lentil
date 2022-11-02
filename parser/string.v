module parser

import ast { Expression }
import ast.expressions { StringExpression }

pub fn parse_string_expression(mut parser Parser) !Expression {
	expression := StringExpression{
		value: parser.current_token.value
	}

	return expression
}
