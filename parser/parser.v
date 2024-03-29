module parser

import os
import lexer
import token { Kind }
import ast { File }
import ast.expressions { Expression }
import ast.statements { Statement, Program, ExpressionStatement }

const statement_parsers = {
	Kind.include: parse_include_statement
	Kind.config:  parse_config_statement
	Kind.date:    parse_date_statement
}

const expression_statement_parsers = {
	Kind.identifier: parse_identifier_expression
}

const expression_parsers = {
	Kind.left_bracket: parse_array_expression
	Kind.literal:      parse_string_expression
	Kind.account:      parse_account_expression
}

pub struct Parser {
	lexer lexer.Lexer
mut:
	current_token token.Token
	tokens        []token.Token
	includes      []Expression
}

pub fn new_parser(mut scanner lexer.Lexer) &Parser {
	return &Parser{
		lexer: scanner
		tokens: scanner.lex()
		includes: []Expression{}
	}
}

pub fn (mut p Parser) parse() !File {
	mut program := Program{}

	if p.tokens.len == 0 {
		return File{
			name: os.base(p.lexer.file_path)
			root: os.real_path(os.dir(p.lexer.file_path))
			path: p.lexer.file_path
			ast: Statement(program)
			includes: p.includes
		}
	}

	p.read_token()

	for p.tokens.len > 0 {
		statement := p.parse_statement() or { return err }

		program.statements << statement

		p.read_token() // skip end of statement like `]`, `string`
	}

	return File{
		name: os.base(p.lexer.file_path)
		root: os.real_path(os.dir(p.lexer.file_path))
		path: p.lexer.file_path
		ast: Statement(program)
		includes: p.includes
	}
}

pub fn (mut p Parser) parse_statement() !Statement {
	if p.current_token.kind in parser.statement_parsers {
		analyser := parser.statement_parsers[p.current_token.kind]
		statement := analyser(mut p)!

		return statement
	}

	return p.parse_expression_statement()!
}

pub fn (mut p Parser) parse_expression_statement() !ExpressionStatement {
	if p.current_token.kind in parser.expression_statement_parsers {
		analyser := parser.expression_statement_parsers[p.current_token.kind]
		expression := analyser(mut p)!

		return ExpressionStatement{
			expression: expression
		}
	}

	return error('parser: unkown expression statement in token `${p.current_token.value}` type ${p.current_token.kind}')
}

pub fn (mut p Parser) parse_expression() !Expression {
	if p.current_token.kind in parser.expression_parsers {
		analyser := parser.expression_parsers[p.current_token.kind]
		expression := analyser(mut p)!

		return expression
	}

	return error('parser: unknown expression in token `${p.current_token.value}` type `${p.current_token.kind}`')
}

pub fn (mut p Parser) parse_expression_list() ![]Expression {
	p.read_token() // skip `[`

	mut expression_list := []Expression{}

	for p.current_token.kind !in [.right_bracket, .end_of_line] {
		expression := p.parse_expression()!

		expression_list << expression

		p.read_token()

		if p.current_token.kind == .comma {
			p.read_token()
		}
	}

	if p.current_token.kind != .right_bracket {
		return error('parser: expected current token to be right bracket but got ${p.current_token.kind}')
	}

	return expression_list
}

pub fn (mut p Parser) read_token() token.Token {
	if p.tokens.len > 0 {
		p.current_token = p.tokens.first()

		p.tokens.delete(0)

		return p.current_token
	} else {
		return p.end_of_line_token()
	}
}

pub fn (mut p Parser) look_next_token() token.Token {
	next_token := p.tokens.first()

	return next_token
}

pub fn (mut p Parser) end_of_line_token() token.Token {
	return token.new_token(Kind.end_of_line, 'eof')
}

// test helper
pub fn create_parser(content string) !File {
	mut scanner := lexer.new_lexer_content(content) or { panic(err) }
	mut analyser := new_parser(mut scanner)

	return analyser.parse()
}
