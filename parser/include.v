module parser

import ast { Statement }
import ast.statements { IncludeStatement }

fn parse_include_statement(mut parser Parser) !Statement {
	next_token_kind := parser.look_next_token().kind

	if next_token_kind != .literal {
		return error('parser: expected next token to be literal but got $next_token_kind')
	}

	statement := IncludeStatement{
		path: parse_string_expression(mut parser)
	}

	return statement
}
