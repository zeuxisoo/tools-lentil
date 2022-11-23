module parser

import ast { Expression }
import ast.expressions { DateRecordsExpression }

fn parse_date_records_expression(mut parser Parser) !Expression {
	parser.read_token()

	mut expressions := []Expression{}

	for parser.current_token.kind !in [.right_brace, .end_of_line] {
		expressions << parse_date_record_expression(mut parser)!
	}

	expression := DateRecordsExpression{
		values: expressions
	}

	return expression
}
