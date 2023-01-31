module main

import cli
import os
import cmd

const version = '2.0.0'

fn main() {
	mut app := cli.Command{
		name: 'Lentil'
		description: 'tools for convert custom syntax to specified syntax'
		version: version
		commands: [
			cmd.token(),
			cmd.parse(),
			cmd.generate(),
		]
	}

	app.setup()
	app.parse(os.args)
}
