module parser

import ast { Statement }
import ast.statements { DateBlockStatement }

fn parse_date_block_statement(mut parser Parser) !Statement {
	parser.read_token()

	statement := DateBlockStatement{
		// TODO: parse to date record expression
	}

	return statement
}
