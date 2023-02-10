module ast

import ast.expressions { Expression  }

pub struct File {
	name     string
	path     string
	includes []Expression
pub:
	root string
	ast  Node
}
