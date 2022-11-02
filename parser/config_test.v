module parser

import ast
import ast.statements
import ast.expressions

fn test_config_statement() {
	program := create_parser('
		config {
			currency = ["hkd", "usd", "jpy"]
		}
	')!

	assert program == ast.Program{
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
	}
}
