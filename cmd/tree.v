module cmd

import cli
import os
import lexer { new_lexer }
import parser { new_parser }

pub fn tree() cli.Command {
	return cli.Command{
		name: 'tree'
		description: 'Display the string of abstract syntax tree'
		execute: tree_action
		flags: [
			cli.Flag{
				flag: .string
				name: 'file'
				abbrev: 'f'
				description: 'which file should be show in the tree'
				required: true
			},
		]
	}
}

fn tree_action(cmd cli.Command) ! {
	file := cmd.flags.get_string('file') or { panic(err) }

	if !os.exists(file) {
		eprintln('file not exists: ${file}')
		return
	}

	mut lexer := new_lexer(file) or { panic(err) }
	mut parser := new_parser(mut lexer)
	mut ast_file := parser.parse() or { panic(err) }

	println(ast_file.ast.str())
}
