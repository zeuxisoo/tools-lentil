module expressions

pub struct ArrayExpression {
pub:
	values []Expression
}

pub fn (a ArrayExpression) ast() string {
	mut output := []string{}

	for value in a.values {
		output << match value {
			StringExpression {
				value.ast()
			}
			else{
				// skip other expression
				""
			}
		}
	}

	return output.join(',')
}
