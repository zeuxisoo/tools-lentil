module parser

import ast { Expression }
import ast.expressions { DateRecordReceiptExpression, AmountExpression }

fn parse_date_record_receipt_expression(mut parser Parser) !Expression {

	account := parse_identifier_expression(mut parser)!
	parser.read_token()

	amounts := parse_amounts_expression(mut parser)!
	parser.read_token()

	expression := DateRecordReceiptExpression{
		account: account,
		amounts: amounts
	}

	return expression
}
