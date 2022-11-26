module parser

import ast { Expression }
import ast.expressions { AmountsExpression }

fn parse_amounts_expression(mut parser Parser) !Expression {
	if parser.current_token.kind !in [.plus, .minus] {
		return AmountsExpression{
			values: []
		}
	}

	mut amounts := [
		parse_amount_expression(mut parser)!,
	]

	for parser.look_next_token().kind == .comma {
		parser.read_token() // sip `,`

		if parser.look_next_token().kind in [.plus, .minus] {
			parser.read_token() // sip `+` or `-`

			amounts << parse_amount_expression(mut parser)!
		}
	}

	expression := AmountsExpression{
		values: amounts
	}

	return expression
}
