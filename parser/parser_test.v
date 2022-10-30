module parser

import ast

fn test_parse_empty_token() {
	program := create_parser('// comment')!

	assert program == ast.Program{
		statements: []
	}
}
