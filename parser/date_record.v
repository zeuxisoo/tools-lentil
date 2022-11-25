module parser

import ast { Expression }
import ast.expressions { DateRecordExpression, DateRecordReceiptExpression }

fn parse_date_record_expression(mut parser Parser) !Expression {
	mut expressions := [
		parse_date_record_receipt_expression(mut parser)!
	]

	for parser.current_token.kind in [.bit_wise_and] {
		if parser.current_token.kind == .bit_wise_and {
			parser.read_token()
		}

		expressions << parse_date_record_receipt_expression(mut parser)!
	}

	// set `is_last` field to true when expression is last element
	mut last_receipt := expressions.last()

	if mut last_receipt is DateRecordReceiptExpression {
		last_receipt.is_last = true
	}

	// create the date record expression
	expression := DateRecordExpression{
		values: expressions
	}

	return expression
}
