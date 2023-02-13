module parser

import ast { Node }
import ast.statements { Statement }
import ast.expressions

fn test_config_statement() {
	analyser := create_parser('
		config {
			currency = ["hkd", "usd", "jpy"]
		}
	')!

	assert analyser.ast == Node(Statement(statements.Program{
		statements: [
			statements.ConfigStatement{
				block: statements.ConfigBlockStatement{
					values: [
						statements.ExpressionStatement{
							expression: expressions.AssignExpression{
								left: expressions.IdentifierExpression{
									value: 'currency'
								}
								right: expressions.ArrayExpression{
									values: [
										expressions.StringExpression{
											value: 'hkd'
										},
										expressions.StringExpression{
											value: 'usd'
										},
										expressions.StringExpression{
											value: 'jpy'
										},
									]
								}
							}
						},
					]
				}
			},
		]
	}))
}
