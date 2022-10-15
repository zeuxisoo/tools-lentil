module cmd

import cli

pub fn parse() cli.Command {
	return cli.Command{
		name: 'parse'
		description: 'Parse the syntax'
		execute: parse_action
	}
}

fn parse_action(cmd cli.Command) ? {
	println('parsing') // TODO
}
