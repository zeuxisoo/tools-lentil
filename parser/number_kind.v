module parser

import ast.expressions { Expression, NumberKindExpression }

fn parse_number_kind_expression(mut p Parser) !Expression {
	expression := NumberKindExpression{
		value: p.current_token.value
	}

	return expression
}
