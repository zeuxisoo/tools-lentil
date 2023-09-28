module parser

import ast.statements { Statement, ConfigStatement }

pub fn parse_config_statement(mut p Parser) !Statement {
	next_token_kind := p.look_next_token().kind

	if next_token_kind != .left_brace {
		return error('parser: expected next token to be left_brace but got ${next_token_kind}')
	}

	p.read_token() // skip `{`

	config := ConfigStatement{
		block: parse_config_block_statement(mut p)!
	}

	return config
}
