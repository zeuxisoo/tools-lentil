module ast

pub struct Program {
pub mut:
	statements []Statement
}

fn (p Program) display() {
	for statement in p.statements {
		statement.display()
	}
}
