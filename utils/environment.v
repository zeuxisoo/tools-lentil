module utils

pub type EnvironmentVariableType = []string | string

pub struct Environment {
pub mut:
	programs  map[string]string
	variables map[string]EnvironmentVariableType
}

pub fn (mut e Environment) add_program(name string, value string) {
	e.programs[name] = value
}

pub fn (mut e Environment) add_variable(name string, value EnvironmentVariableType) {
	e.variables[name] = value
}
