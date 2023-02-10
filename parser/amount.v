module parser

import ast.expressions { Expression, AmountExpression }

fn parse_amount_expression(mut parser Parser) !Expression {
	expression := AmountExpression{
		value: parse_number_expression(mut parser)!
		currency: parse_identifier_expression(mut parser)!
	}

	return expression
}
