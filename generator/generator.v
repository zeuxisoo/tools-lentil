module generator

import ast { Node, Statement }
import parser
import utils { Environment }

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

	g.produce(ast_file.ast, environment)
}

fn (mut g Generator) produce(node Node, environment Environment) []string {
	return match node {
		ast.Program {
			mut codes := []string{}

			for statement in node.statements {
				codes << g.produce(statement as Node, environment)
			}

			codes
		}
		// TODO: implement other nodes
		else {
			panic('Unknown node: $node')
		}
	}
}
