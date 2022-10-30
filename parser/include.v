module parser

import ast { Statement, Expression }
import ast.statements { IncludeStatement }

fn parse_include_statement(mut parser Parser) Statement {
	statement := IncludeStatement{
		path: parser.parse_string_expression()
	}

	return statement
}
