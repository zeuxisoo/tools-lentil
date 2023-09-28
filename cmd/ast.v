module cmd

import cli
import os
import lexer { new_lexer }
import parser { new_parser }
import ast.statements { Statement }

pub fn ast() cli.Command {
	return cli.Command{
		name: 'ast'
		description: 'Display the parsed abstract syntax tree'
		execute: ast_action
		flags: [
			cli.Flag{
				flag: .string
				name: 'file'
				abbrev: 'f'
				description: 'which file should be in the abstract syntax tree'
				required: true
			},
		]
	}
}

fn ast_action(c cli.Command) ! {
	file := c.flags.get_string('file') or { panic(err) }

	if !os.exists(file) {
		eprintln('file not exists: ${file}')
		return
	}

	mut scanner := new_lexer(file) or { panic(err) }
	mut analyser := new_parser(mut scanner)
	mut ast_file := analyser.parse() or { panic(err) }

	println((ast_file.ast as Statement).str())
}
