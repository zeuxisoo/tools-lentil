module parser

import ast.statements { Statement, DateStatement }

fn parse_date_statement(mut p Parser) !Statement {
	current_token_value := p.current_token.value
	current_token_kind := p.current_token.kind

	if current_token_kind != .date {
		return error('parser: expected current token to be date but got ${current_token_kind}')
	}

	statement := DateStatement{
		value: current_token_value
		block: parse_date_block_statement(mut p)!
	}

	return statement
}
