module expressions

pub struct ArrayExpression {
pub:
	values []Expression
}

pub fn (a ArrayExpression) ast_str() string {
	mut output := []string{}

	for value in a.values {
		output << match value {
			StringExpression {
				value.ast_str()
			}
			else{
				// skip other expression
				""
			}
		}
	}

	return output.join(',')
}
