module cmd

import cli
import os
import lexer { new_lexer }
import parser { new_parser }

pub fn expose() cli.Command {
	return cli.Command{
		name: 'expose'
		description: 'Expose the abstract syntax tree string'
		execute: expose_action
		flags: [
			cli.Flag{
				flag: .string
				name: 'file'
				abbrev: 'f'
				description: 'which file should be expose'
				required: true
			},
		]
	}
}

fn expose_action(cmd cli.Command) ! {
	file := cmd.flags.get_string('file') or { panic(err) }

	if !os.exists(file) {
		eprintln('file not exists: ${file}')
		return
	}

	mut lexer := new_lexer(file) or { panic(err) }
	mut parser := new_parser(mut lexer)
	mut ast_file := parser.parse() or { panic(err) }

	// TODO: print the ast string
	ast_file.ast.display()
}
