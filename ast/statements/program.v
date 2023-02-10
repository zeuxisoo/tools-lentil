module statements

pub struct Program {
pub mut:
	statements []Statement
}

pub fn (p Program) ast() string {
	mut output := []string{}

	for statement in p.statements {
		result := match statement {
			ConfigStatement {
				statement.ast()
			}
			ConfigBlockStatement {
				statement.ast()
			}
			DateStatement {
				statement.ast()
			}
			DateBlockStatement {
				statement.ast()
			}
			ExpressionStatement {
				statement.ast()
			}
			IncludeStatement {
				statement.ast()
			}
			Program{
				// skip Program
				""
			}
		}

		output << result
	}

	return output.join('\n')
}
