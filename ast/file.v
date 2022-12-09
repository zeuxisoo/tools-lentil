module ast

pub struct File {
	name     string
	path     string
	includes []Expression
pub:
	root string
	ast  Node
}
