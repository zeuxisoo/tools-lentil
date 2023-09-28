module parser

import ast.statements { Statement, DateBlockStatement }

fn parse_date_block_statement(mut p Parser) !Statement {
	p.read_token() // skip `{`

	statement := DateBlockStatement{
		value: parse_date_records_expression(mut p)!
	}

	return statement
}
