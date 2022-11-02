module parser

import ast { Statement }
import ast.statements { IncludeStatement }

fn parse_include_statement(mut parser Parser) Statement {
	statement := IncludeStatement{
		path: parse_string_expression(mut parser)
	}

	return statement
}
