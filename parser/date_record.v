module parser

import ast.expressions { Expression, DateRecordExpression, DateRecordReceiptExpression }

fn parse_date_record_expression(mut p Parser) !Expression {
	mut expression_list := [
		parse_date_record_receipt_expression(mut p)!,
	]

	for p.current_token.kind == .bit_wise_and {
		if p.current_token.kind == .bit_wise_and {
			p.read_token()
		}

		expression_list << parse_date_record_receipt_expression(mut p)!
	}

	// set `is_last` field to true when expression is last element
	mut last_receipt := expression_list.last()

	if mut last_receipt is DateRecordReceiptExpression {
		last_receipt.is_last = true
	}

	// create the date record expression
	expression := DateRecordExpression{
		values: expression_list
		title: parse_atom_expression(mut p)!
		description: parse_atom_expression(mut p)!
	}

	return expression
}
