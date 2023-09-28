module parser

import ast.expressions { Expression, AtomExpression }

fn parse_atom_expression(mut p Parser) !Expression {
	current_token := p.current_token

	value := if current_token.kind == .atom {
		current_token.value
	} else {
		''
	}

	if value != '' {
		p.read_token()
	}

	expression := AtomExpression{
		value: value
	}

	return expression
}
