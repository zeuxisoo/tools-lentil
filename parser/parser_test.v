module parser

import ast

fn test_parse_empty_token() {
	analyser := create_parser('// comment')!

	assert analyser.ast == ast.Program{
		statements: []
	}
}
