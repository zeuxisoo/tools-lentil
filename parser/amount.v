module parser

import ast.expressions { Expression, AmountExpression }

fn parse_amount_expression(mut p Parser) !Expression {
	expression := AmountExpression{
		value: parse_number_expression(mut p)!
		currency: parse_identifier_expression(mut p)!
	}

	return expression
}
