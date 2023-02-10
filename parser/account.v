module parser

import ast.expressions { Expression, AccountExpression }
import token { find_account_kind }

pub fn parse_account_expression(mut parser Parser) !Expression {
	expression := AccountExpression{
		value: parser.current_token.value
		kind: find_account_kind(parser.current_token.value)
	}

	return expression
}
