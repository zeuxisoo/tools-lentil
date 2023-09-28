module parser

import ast.expressions { Expression, AccountExpression }
import token { find_account_kind }

pub fn parse_account_expression(mut p Parser) !Expression {
	expression := AccountExpression{
		value: p.current_token.value
		kind: find_account_kind(p.current_token.value)
	}

	return expression
}
