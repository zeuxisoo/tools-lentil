module ast

pub struct File {
	name     string
	root     string
	path     string
	includes []Expression
pub:
	ast Program
}
