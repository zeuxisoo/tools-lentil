module parser

import ast.expressions { Expression, DateRecordsExpression }

fn parse_date_records_expression(mut p Parser) !Expression {
	p.read_token()

	mut expression_list := []Expression{}

	for p.current_token.kind !in [.right_brace, .end_of_line] {
		expression_list << parse_date_record_expression(mut p)!
	}

	expression := DateRecordsExpression{
		values: expression_list
	}

	return expression
}
