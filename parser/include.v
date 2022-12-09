module parser

import ast { Statement }
import ast.statements { IncludeStatement }

fn parse_include_statement(mut parser Parser) !Statement {
	next_token_kind := parser.look_next_token().kind

	if next_token_kind != .literal {
		return error('parser: expected next token to be literal but got ${next_token_kind}')
	}

	parser.read_token() // skip `"`

	include_path := parse_string_expression(mut parser)!

	statement := IncludeStatement{
		path: include_path
	}

	parser.includes << include_path

	return statement
}
