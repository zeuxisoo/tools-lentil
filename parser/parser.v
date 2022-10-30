module parser

import lexer
import token { Kind }
import ast { Expression, Program, Statement }
import ast.statements { IncludeStatement }
import ast.expressions { StringExpression }

[heap]
struct Parser {
	lexer lexer.Lexer
mut:
	current_token token.Token
	tokens        []token.Token
	includes      []string
}

pub fn new_parser(mut lexer lexer.Lexer) &Parser {
	return &Parser{
		lexer: lexer
		tokens: lexer.lex()
		includes: []string{}
	}
}

pub fn (mut p Parser) parse() Program {
	p.current_token = p.read_token()

	mut program := Program{}

	for p.tokens.len > 0 {
		statement := p.parse_statement()

		program.statements << statement
	}

	return program
}

pub fn (mut p Parser) parse_statement() Statement {
	statement_parsers := {
		Kind.include: parse_include_statement
	}

	if p.current_token.kind == .include {
		return statement_parsers[p.current_token.kind](mut p)
	}

	// TODO: remove when other token parser completed
	p.read_token()

	return IncludeStatement{
		path: StringExpression{
			value: 'TODO: other token parser'
		}
	}
}

pub fn (mut p Parser) read_token() token.Token {
	token := p.tokens.first()

	p.tokens.delete(0)

	return token
}
