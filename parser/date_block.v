module parser

import ast { Statement }
import ast.statements { DateBlockStatement }

fn parse_date_block_statement(mut parser Parser) !Statement {
	parser.read_token() // eat the `{`

	statement := DateBlockStatement{
		value: parse_date_records_expression(mut parser)!
	}

	return statement
}
