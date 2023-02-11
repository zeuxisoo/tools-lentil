module statements

pub struct Program {
pub mut:
	statements []Statement
}

pub fn (p Program) ast_str() string {
	mut output := []string{}

	for statement in p.statements {
		result := match statement {
			ConfigStatement {
				statement.ast_str()
			}
			ConfigBlockStatement {
				statement.ast_str()
			}
			DateStatement {
				statement.ast_str()
			}
			DateBlockStatement {
				statement.ast_str()
			}
			ExpressionStatement {
				statement.ast_str()
			}
			IncludeStatement {
				statement.ast_str()
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
