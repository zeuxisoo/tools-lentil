module cmd

import cli
import os
import lexer { new_lexer }

pub fn parse() cli.Command {
	return cli.Command{
		name: 'parse'
		description: 'Parse the syntax'
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

fn parse_action(cmd cli.Command) ? {
	file := cmd.flags.get_string('file') or { panic(err) }

	if !os.exists(file) {
		eprintln('file not exists: $file')
		return
	}

	mut lexer := new_lexer(file) or { panic(err) }

	println(lexer.lex())
}
