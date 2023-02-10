module cmd

import cli
import os
import lexer { new_lexer }
import parser { new_parser }

pub fn parse() cli.Command {
	return cli.Command{
		name: 'parse'
		description: 'Display the string of parsed content'
		execute: parse_action
		flags: [
			cli.Flag{
				flag: .string
				name: 'file'
				abbrev: 'f'
				description: 'which file should be parse'
				required: true
			},
		]
	}
}

fn parse_action(cmd cli.Command) ! {
	file := cmd.flags.get_string('file') or { panic(err) }

	if !os.exists(file) {
		eprintln('file not exists: ${file}')
		return
	}

	mut scanner := new_lexer(file) or { panic(err) }
	mut analyser := new_parser(mut scanner)
	mut ast_file := analyser.parse() or { panic(err) }

	println(ast_file.ast.str())
}
