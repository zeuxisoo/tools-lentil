module generator

import os
import ast { Node, Program }
import ast.statements { IncludeStatement }
import ast.expressions { StringExpression }
import lexer
import parser
import utils { Environment }

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

	result := g.produce(ast_file.ast, environment)

	dump(result)
}

fn (mut g Generator) produce(node Node, environment Environment) ProduceType {
	return match node {
		Program {
			mut codes := []string{}

			for statement in node.statements {
				code := g.produce(statement as Node, environment)

				if code is string {
					codes << code
				}
			}

			codes
		}
		IncludeStatement {
			file_path := g.produce(node.path as Node, environment)
			full_path := os.join_path_single(environment.program['root'], file_path as string)

			mut lexer := lexer.new_lexer(full_path) or { panic(err) }
			mut parser := parser.new_parser(mut lexer)

			ast_file := parser.parse() or { panic(err) }

			g.produce(ast_file.ast, environment)
		}
		StringExpression {
			node.value
		}
		// TODO: implement other nodes
		else {
			panic('Unknown node: ${node}')
		}
	}
}
