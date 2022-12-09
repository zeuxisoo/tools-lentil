module utils

pub struct Environment {
mut:
	program map[string]string
}

pub fn (mut e Environment) add_program(name string, value string) {
	e.program[name] =value
}
