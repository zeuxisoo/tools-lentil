module parser

import ast.expressions { Expression, ArrayExpression }

pub fn parse_array_expression(mut p Parser) !Expression {
	return ArrayExpression{
		values: p.parse_expression_list()!
	}
}
