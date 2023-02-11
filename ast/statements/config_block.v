module statements

pub struct ConfigBlockStatement {
pub:
	values []Statement
}

pub fn (cb ConfigBlockStatement) ast_str() string {
	mut output := []string{}

	for value in cb.values {
		output << match value {
			ConfigStatement {
				value.ast_str()
			}
			ConfigBlockStatement {
				value.ast_str()
			}
			DateStatement {
				value.ast_str()
			}
			DateBlockStatement {
				value.ast_str()
			}
			ExpressionStatement {
				value.ast_str()
			}
			IncludeStatement {
				value.ast_str()
			}
			Program{
				// skip Program
				""
			}
		}
	}

	return output.join(',')
}
