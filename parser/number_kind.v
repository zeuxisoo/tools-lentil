module parser

import ast.expressions { Expression, NumberKindExpression }

fn parse_number_kind_expression(mut parser Parser) !Expression {
	expression := NumberKindExpression{
		value: parser.current_token.value
	}

	return expression
}
