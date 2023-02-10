module parser

import ast.statements { Statement, DateBlockStatement }

fn parse_date_block_statement(mut parser Parser) !Statement {
	parser.read_token() // skip `{`

	statement := DateBlockStatement{
		value: parse_date_records_expression(mut parser)!
	}

	return statement
}
