module parser

import ast.expressions { Expression, AmountsExpression }

fn parse_amounts_expression(mut p Parser) !Expression {
	if p.current_token.kind !in [.plus, .minus] {
		return AmountsExpression{
			values: []
		}
	}

	mut amounts := [
		parse_amount_expression(mut p)!,
	]

	for p.look_next_token().kind == .comma {
		p.read_token() // sip `,`

		if p.look_next_token().kind in [.plus, .minus] {
			p.read_token() // sip `+` or `-`

			amounts << parse_amount_expression(mut p)!
		}
	}

	expression := AmountsExpression{
		values: amounts
	}

	return expression
}
