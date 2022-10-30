module parser

import lexer
import token { Kind }
import ast { Program, Statement }
import ast.statements { IncludeStatement }
import ast.expressions { StringExpression }

const statement_parsers = {
	Kind.include: parse_include_statement
}

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
	mut program := Program{}

	if p.tokens.len == 0 {
		return program
	}

	p.current_token = p.read_token()

	for p.tokens.len > 0 {
		statement := p.parse_statement()

		program.statements << statement
	}

	return program
}

pub fn (mut p Parser) parse_statement() Statement {
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

// test helper
pub fn create_parser(content string) !Program {
	mut lexer := lexer.new_lexer_content(content) or { panic(err) }
	mut parser := new_parser(mut lexer)

	return parser.parse()
}
