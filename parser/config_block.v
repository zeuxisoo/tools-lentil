module parser

import ast.statements { Statement, ConfigBlockStatement }

pub fn parse_config_block_statement(mut p Parser) !Statement {
	p.read_token() // skip `{`

	mut values := []Statement{}

	for p.current_token.kind !in [.right_brace, .end_of_line] {
		values << p.parse_statement()!

		p.read_token()
	}

	config_block := ConfigBlockStatement{
		values: values
	}

	return config_block
}
