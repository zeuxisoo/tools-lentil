module generator

import os
import arrays
import ast { Node, Program }
import ast.statements { IncludeStatement, ConfigStatement, ConfigBlockStatement, DateStatement, DateBlockStatement, ExpressionStatement }
import ast.expressions { StringExpression, IdentifierExpression, AccountExpression, AtomExpression, ArrayExpression, AssignExpression, AmountsExpression, AmountExpression, NumberExpression, NumberKindExpression, DateRecordsExpression, DateRecordExpression, DateRecordReceiptExpression }
import lexer
import parser
import utils { Environment, EnvironmentConfigType, EnvironmentVariableType }

type ProduceMapValue = string | bool | int | []map[string]ProduceMapValue
type ProduceType = []string | string | map[string]ProduceMapValue | []map[string]ProduceMapValue

struct Generator {
mut:
	parser parser.Parser
}

pub fn new_generator(mut parser parser.Parser) &Generator {
	return &Generator{
		parser: parser
	}
}

pub fn (mut g Generator) generate() ! {
	ast_file := g.parser.parse()!

	mut environment := Environment{}
	environment.add_program('root', ast_file.root)

	result := g.produce(ast_file.ast, mut environment) as []string

	println(result.join('\n'))
}

fn (mut g Generator) produce(node Node, mut environment Environment) ProduceType {
	return match node {
		Program {
			mut codes := []string{}

			for statement in node.statements {
				code := g.produce(statement as Node, mut environment)

				if code is string {
					if code.len > 0 {
						codes << code
					}
				}
			}

			codes
		}
		IncludeStatement {
			file_path := g.produce(node.path as Node, mut environment)
			full_path := os.join_path_single(environment.programs['root'], file_path as string)

			mut lexer := lexer.new_lexer(full_path) or { panic(err) }
			mut parser := parser.new_parser(mut lexer)

			ast_file := parser.parse() or { panic(err) }

			g.produce(ast_file.ast, mut environment)
		}
		ConfigStatement {
			g.produce(node.block as Node, mut environment)
		}
		ConfigBlockStatement {
			for value in node.values {
				if value is ExpressionStatement {
					expression := value.expression

					if expression is AssignExpression {
						name := g.produce(expression.left as Node, mut environment) as string
						data := g.produce(expression.right as Node, mut environment)

						if data is []string {
							environment.add_config(name, EnvironmentConfigType(data))
						}
					}
				}
			}

			''
		}
		DateStatement {
			date := node.value
			rows := g.produce(node.block as Node, mut environment) as []map[string]ProduceMapValue

			escape_quote := fn(value string) string {
				return value.replace('"', '\"')
			}

			mut contents := []string{}

			for row in rows {
				title := escape_quote(row['title'] or { "" } as string)
				description := escape_quote(row['description'] or { "" } as string)

				contents << '${date} * "${title}" "${description}"'

				contents << g.generate_date(row)
			}

			contents.join('\n')
		}
		DateBlockStatement {
			g.produce(node.value as Node, mut environment)
		}
		DateRecordsExpression {
			mut records := []map[string]ProduceMapValue{}

			for value in node.values {
				record := g.produce(value as Node, mut environment)

				records << record as map[string]ProduceMapValue
			}

			records
		}
		DateRecordExpression {
			mut receipts := []map[string]ProduceMapValue{}

			for value in node.values {
				receipt := g.produce(value as Node, mut environment)

				receipts << receipt as map[string]ProduceMapValue
			}

			title := g.produce(node.title as Node, mut environment) as string
			description := g.produce(node.description as Node, mut environment) as string

			mut records := map[string]ProduceMapValue{}
			records['title']       = title
			records['description'] = description
			records['receipts']    = receipts

			records
		}
		DateRecordReceiptExpression {
			account_name := g.produce(node.account as Node, mut environment) as string
			account_value := environment.variables[account_name] or {
				panic('generator: account name not found, got `$account_name`')
			} as string

			// find longest account to calculate whitespace between account and currency
			longest_account := arrays.reduce(environment.variables.values(), fn(a EnvironmentVariableType, b EnvironmentVariableType) EnvironmentVariableType {
				a_value := a as string
				b_value := b as string

				return if a_value.len > b_value.len { a }else{ b }
			}) or {
				panic('generator: cannot found max length account in environment variable table')
			}

			whitespace_length := (longest_account as string).len - account_value.len + 4

			// find manually input amount
			amounts := node.amounts

			amount := if amounts is AmountsExpression {
				if amounts.values.len > 0 {
					g.produce(amounts, mut environment)
				}else{
					[]map[string]ProduceMapValue{}
				}
			}else{
				panic('generator: expected amount expression, but got `$amounts`')
			} as []map[string]ProduceMapValue

			// return ProduceType
			mut receipts := map[string]ProduceMapValue{}
			receipts['account']    = account_value
			receipts['amount']     = amount
			receipts['is_last']    = node.is_last
			receipts['whitespace'] = whitespace_length

			receipts

			// return {
			// 	"account"   : account_value
			// "amount"    : amount
			// 	"is_last"   : node.is_last
			// 	"whitespace": whitespace_length
			// }
		}
		ExpressionStatement {
			g.produce(node.expression as Node, mut environment)
		}
		StringExpression {
			node.value
		}
		IdentifierExpression {
			node.value
		}
		AccountExpression {
			node.value
		}
		AtomExpression {
			node.value
		}
		ArrayExpression {
			mut items := []string{}

			for value in node.values {
				items << g.produce(value as Node, mut environment) as string
			}

			items
		}
		AssignExpression {
			name := g.produce(node.left as Node, mut environment) as string
			data := g.produce(node.right as Node, mut environment)

			if data is string {
				environment.add_variable(name, EnvironmentVariableType(data))
			}

			''
		}
		AmountsExpression {
			mut amounts := []map[string]ProduceMapValue{}

			for amount in node.values {
				amounts << g.produce(amount as Node, mut environment) as map[string]ProduceMapValue
			}

			amounts
		}
		AmountExpression {
			price := g.produce(node.value as Node, mut environment) as string
			currency := g.produce(node.value as Node, mut environment) as string

			mut amount := map[string]ProduceMapValue{}
			amount['price'] = price
			amount['currency'] = currency

			amount

			// return {
			// 	"price"   : price,
			// 	"currency": currency
			// }
		}
		NumberExpression {
			kind := g.produce(node.kind as Node, mut environment) as string
			value := node.value

			'${kind}${value}'
		}
		NumberKindExpression {
			node.value
		}
		else {
			panic('generator: unknown node: ${node}')
		}
	}
}

fn (mut g Generator) generate_date(record_row map[string]ProduceMapValue) string {
	// TODO: generate each date record
	return ""
}
