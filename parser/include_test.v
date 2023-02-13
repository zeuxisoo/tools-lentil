module parser

import ast { Node }
import ast.statements { Statement }
import ast.expressions

fn test_include_statement() {
	analyser := create_parser('include "dummy.tin"')!

	assert analyser.ast == Node(Statement(statements.Program{
		statements: [
			statements.IncludeStatement{
				path: expressions.StringExpression{
					value: 'dummy.tin'
				}
			},
		]
	}))
}
