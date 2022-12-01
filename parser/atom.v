module parser

import ast { Expression }
import ast.expressions { AtomExpression }

fn parse_atom_expression(mut parser Parser) !Expression {
	current_token := parser.current_token

	value := if current_token.kind == .atom {
		current_token.value
	} else {
		''
	}

	if value != '' {
		parser.read_token()
	}

	expression := AtomExpression{
		value: value
	}

	return expression
}
