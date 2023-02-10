module statements

pub struct ConfigBlockStatement {
pub:
	values []Statement
}

pub fn (cb ConfigBlockStatement) ast() string {
	mut output := []string{}

	for value in cb.values {
		output << match value {
			ConfigStatement {
				value.ast()
			}
			ConfigBlockStatement {
				value.ast()
			}
			DateStatement {
				value.ast()
			}
			DateBlockStatement {
				value.ast()
			}
			ExpressionStatement {
				value.ast()
			}
			IncludeStatement {
				value.ast()
			}
			Program{
				// skip Program
				""
			}
		}
	}

	return output.join(',')
}
