module parser

import ast.statements { Statement, IncludeStatement }

fn parse_include_statement(mut p Parser) !Statement {
	next_token_kind := p.look_next_token().kind

	if next_token_kind != .literal {
		return error('parser: expected next token to be literal but got ${next_token_kind}')
	}

	p.read_token() // skip `"`

	include_path := parse_string_expression(mut p)!

	statement := IncludeStatement{
		path: include_path
	}

	p.includes << include_path

	return statement
}
