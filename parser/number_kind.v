module parser

import ast { Expression }
import ast.expressions { NumberKindExpression }

fn parse_number_kind_expression(mut parser Parser) !Expression {
	expression := NumberKindExpression{
		value: parser.current_token.value
	}

	return expression
}
