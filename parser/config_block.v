module parser

import ast.statements { Statement, ConfigBlockStatement }

pub fn parse_config_block_statement(mut parser Parser) !Statement {
	parser.read_token() // skip `{`

	mut values := []Statement{}

	for parser.current_token.kind !in [.right_brace, .end_of_line] {
		values << parser.parse_statement()!

		parser.read_token()
	}

	config_block := ConfigBlockStatement{
		values: values
	}

	return config_block
}
