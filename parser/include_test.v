module parser

import ast
import ast.statements
import ast.expressions

fn test_include_statement() {
	program := create_parser('include "dummy.tin"')!

	assert program == ast.Program{
		statements: [
			statements.IncludeStatement{
				path: expressions.StringExpression{
					value: 'dummy.tin'
				}
			},
		]
	}
}
