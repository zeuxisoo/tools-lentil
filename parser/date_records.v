module parser

import ast { Expression }
import ast.expressions { DateRecordsExpression }

fn parse_date_records_expression(mut parser Parser) !Expression {
	parser.read_token()

	expression := DateRecordsExpression{
		// TODO: parse date receipt expression
	}

	return expression
}
