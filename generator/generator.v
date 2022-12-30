module generator

import os
import ast { Node, Program }
import ast.statements { IncludeStatement, ConfigStatement, ConfigBlockStatement, DateStatement, DateBlockStatement, ExpressionStatement }
import ast.expressions { StringExpression, IdentifierExpression, AccountExpression, AtomExpression, ArrayExpression, AssignExpression, DateRecordsExpression, DateRecordExpression, DateRecordReceiptExpression }
import lexer
import parser
import utils { Environment, EnvironmentVariableType }

type ProduceType = []string | string

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

	result := g.produce(ast_file.ast, mut environment)

	dump(result)
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
				g.produce(value as Node, mut environment)
			}

			""
		}
		DateStatement {
			date := node.value
			rows := g.produce(node.block as Node, mut environment)

			// TODO: generate each row
			dump(date)
			dump(rows)
		}
		DateBlockStatement {
			g.produce(node.value as Node, mut environment)
		}
		DateRecordsExpression {
			mut records := []string{}

			for value in node.values {
				record := g.produce(value as Node, mut environment)

				records << record as string
			}

			records
		}
		DateRecordExpression {
			mut receipts := []string{}

			for value in node.values {
				receipt := g.produce(value as Node, mut environment)

				receipts << receipt as string
			}

			title := g.produce(node.title as Node, mut environment)
			description := g.produce(node.description as Node, mut environment)

			// TODO: return receipts, title and description
			dump(title)
			dump(description)
		}
		DateRecordReceiptExpression {
			account := g.produce(node.account as Node, mut environment)

			// TODO: return account, amount, is_last and whitespace
			dump(account)
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

			if data is []string {
				environment.add_variable(name, EnvironmentVariableType(data))
			}

			""
		}
		// TODO: implement other nodes
		else {
			panic('generator: unknown node: ${node}')
		}
	}
}
