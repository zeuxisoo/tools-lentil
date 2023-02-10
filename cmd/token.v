module cmd

import cli
import os
import lexer { new_lexer }

pub fn token() cli.Command {
	return cli.Command{
		name: 'token'
		description: 'Display the token list'
		execute: token_action
		flags: [
			cli.Flag{
				flag: .string
				name: 'file'
				abbrev: 'f'
				description: 'which file should be show in the token list'
				required: true
			},
		]
	}
}

fn token_action(cmd cli.Command) ! {
	file := cmd.flags.get_string('file') or { panic(err) }

	if !os.exists(file) {
		eprintln('file not exists: ${file}')
		return
	}

	mut scanner := new_lexer(file) or { panic(err) }

	for token in scanner.lex() {
		kind := token.kind
		value := token.value

		println('Kind: ${kind:-20} | Value: ${value}')
	}
}
