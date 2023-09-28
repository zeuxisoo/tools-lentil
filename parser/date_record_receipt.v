module parser

import ast.expressions { Expression, DateRecordReceiptExpression }

fn parse_date_record_receipt_expression(mut p Parser) !Expression {
	account := parse_identifier_expression(mut p)!
	p.read_token()

	has_amounts := p.current_token.kind in [.plus, .minus]
	amounts := parse_amounts_expression(mut p)!

	if has_amounts {
		p.read_token()
	}

	expression := DateRecordReceiptExpression{
		account: account
		amounts: amounts
		is_last: false
	}

	return expression
}
