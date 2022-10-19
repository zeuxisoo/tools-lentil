module lexer

import os
import token

pub struct Lexer {
	file_path      string
	current_column int
	current_line   int
mut:
	content          string
	current_position int
	tokens           []token.Token
}

pub fn new_lexer(file_path string) ?&Lexer {
	if !os.is_file(file_path) {
		return error('file path is not file: $file_path')
	}

	content := os.read_file(file_path) or { return error('failed to open file: $file_path') }

	return &Lexer{
		file_path: file_path
		content: content
	}
}

pub fn (mut l Lexer) lex() {
	content_length := l.content.len

	for l.current_position < content_length {
		l.skip_whitespace()

		look_char := l.look_char()

		token := match look_char {
			`{` {
				l.new_token(.left_brace, l.read_char())
			}
			`}` {
				l.new_token(.right_brace, l.read_char())
			}
			10 { // newline
				l.read_char()
				l.new_token(.end_of_line, '')
			}
			else {
				if look_char.is_letter() {
					l.new_token(.identifier, l.read_identifer())
				} else {
					l.new_token(.unknown, '')
				}
			}
		}

		l.tokens << token
	}

	println(l.tokens)
}

fn (mut l Lexer) look_char() u8 {
	current_position := l.current_position

	if current_position < l.content.len {
		return l.content[current_position]
	}

	return u8(C.EOF)
}

fn (mut l Lexer) read_char() u8 {
	current_char := l.content[l.current_position]

	l.current_position = l.current_position + 1

	return current_char
}

fn (mut l Lexer) skip_whitespace() {
	for {
		look_char := l.look_char()

		if look_char == ` ` || look_char == `\t` {
			l.read_char()
		}else{
			break
		}
	}
}

fn (mut l Lexer) read_identifer() string {
	mut identifier := [l.read_char()]

	for {
		look_char := l.look_char()

		if look_char.is_letter() || look_char == `_` {
			identifier << l.read_char()
		} else {
			break
		}
	}

	return identifier.bytestr()
}

fn (mut l Lexer) new_token(kind token.Kind, value token.TokenValue) token.Token {
	return token.Token{
		kind: kind
		value: match value {
			string {
				value
			}
			u8 {
				unsafe { value.vstring() }
			}
		}
	}
}
