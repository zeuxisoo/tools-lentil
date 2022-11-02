module parser

import ast { Statement }
import ast.statements { ConfigStatement }

pub fn parse_config_statement(mut parser Parser) !Statement {
	next_token_kind := parser.look_next_token().kind

	if next_token_kind != .left_brace {
		return error('parser: expected next token to be left_brace but got $next_token_kind')
	}

	parser.read_token() // move to config block `{`

	config := ConfigStatement{
		block: parse_config_block_statement(mut parser)!
	}

	return config
}
