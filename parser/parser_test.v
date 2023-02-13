module parser

import ast { Node }
import ast.statements { Statement }

fn test_parse_empty_token() {
	analyser := create_parser('// comment')!

	assert analyser.ast == Node(Statement(statements.Program{
		statements: []
	}))
}
