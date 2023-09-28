module parser

import ast.expressions { Expression, NumberExpression }

fn parse_number_expression(mut p Parser) !Expression {
	kind := parse_number_kind_expression(mut p)!
	p.read_token()

	value := p.current_token.value
	p.read_token()

	expression := NumberExpression{
		kind: kind
		value: value
	}

	return expression
}
