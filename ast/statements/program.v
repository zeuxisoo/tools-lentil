module statements

pub struct Program {
pub mut:
	statements []Statement
}

fn (p Program) str() string {
	mut output := []string{}

	for statement in p.statements {
		output << statement.str()
	}

	return output.join('\n')
}
