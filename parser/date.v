module parser

import ast { Statement }
import ast.statements { DateStatement }

fn parse_date_statement(mut parser Parser) !Statement {
	current_token_kind := parser.current_token.kind

	if current_token_kind != .date {
		return error('parser: expected current token to be date but got $current_token_kind')
	}

	statement := DateStatement{
		// TODO: implment block
	}

	return statement
}
