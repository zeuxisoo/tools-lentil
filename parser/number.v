module parser

import ast.expressions { Expression, NumberExpression }

fn parse_number_expression(mut parser Parser) !Expression {
	kind := parse_number_kind_expression(mut parser)!
	parser.read_token()

	value := parser.current_token.value
	parser.read_token()

	expression := NumberExpression{
		kind: kind
		value: value
	}

	return expression
}
