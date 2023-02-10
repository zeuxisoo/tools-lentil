module cmd

import cli
import os
import lexer { new_lexer }
import parser { new_parser }
import generator { new_generator }

pub fn generate() cli.Command {
	return cli.Command{
		name: 'generate'
		description: 'Generate bean file from the lentil file'
		execute: generate_action
		flags: [
			cli.Flag{
				flag: .string
				name: 'file'
				abbrev: 'f'
				description: 'which file should be generate'
				required: true
			},
			cli.Flag{
				flag: .string
				name: 'output'
				abbrev: 'o'
				description: 'which file is used to store'
				required: false
			}
		]
	}
}

fn generate_action(cmd cli.Command) ! {
	file := cmd.flags.get_string('file') or { panic(err) }
	output := cmd.flags.get_string('output') or { panic(err) }

	if !os.exists(file) {
		eprintln('file not exists: ${file}')
		return
	}

	mut scanner := new_lexer(file) or { panic(err) }
	mut analyser := new_parser(mut scanner)
	mut producer := new_generator(mut analyser)

	result := producer.generate() or {
		eprintln(err)
		return
	}

	if output.len > 0 {
		folder_path := os.abs_path(os.dir(output))

		if !os.exists(folder_path) {
			eprintln('folder path is not exists: ${folder_path}')
			return
		}

		os.write_file(output, result) or {
			eprintln(err)
			return
		}
	}

	println(result)
}
