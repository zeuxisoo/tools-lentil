module parser

import ast.expressions { Expression, ArrayExpression }

pub fn parse_array_expression(mut parser Parser) !Expression {
	return ArrayExpression{
		values: parser.parse_expression_list()!
	}
}
