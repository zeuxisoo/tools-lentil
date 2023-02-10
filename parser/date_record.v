module parser

import ast.expressions { Expression, DateRecordExpression, DateRecordReceiptExpression }

fn parse_date_record_expression(mut parser Parser) !Expression {
	mut expression_list := [
		parse_date_record_receipt_expression(mut parser)!,
	]

	for parser.current_token.kind == .bit_wise_and {
		if parser.current_token.kind == .bit_wise_and {
			parser.read_token()
		}

		expression_list << parse_date_record_receipt_expression(mut parser)!
	}

	// set `is_last` field to true when expression is last element
	mut last_receipt := expression_list.last()

	if mut last_receipt is DateRecordReceiptExpression {
		last_receipt.is_last = true
	}

	// create the date record expression
	expression := DateRecordExpression{
		values: expression_list
		title: parse_atom_expression(mut parser)!
		description: parse_atom_expression(mut parser)!
	}

	return expression
}
