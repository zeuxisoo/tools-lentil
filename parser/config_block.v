module parser

import ast { Statement }
import ast.statements { ConfigBlockStatement }

pub fn parse_config_block_statement(mut parser Parser) !Statement {
	parser.read_token() // eat `{`

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
