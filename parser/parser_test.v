module parser

import ast

fn test_parse_empty_token() {
	parser := create_parser('// comment')!

	assert parser.ast == ast.Program{
		statements: []
	}
}
