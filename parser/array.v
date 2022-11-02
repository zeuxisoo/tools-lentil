module parser

import ast { Expression }
import ast.expressions { ArrayExpression }

pub fn parse_array_expression(mut parser Parser) !Expression {
	return ArrayExpression{
		values: parser.parse_expression_list()!
	}
}
