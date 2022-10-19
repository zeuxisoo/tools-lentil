module lexer

import os
import token

const (
	char_lf = 10 // line feed, new line
	char_cr = 13 // carriage return
)

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

pub fn new_lexer_content(content string) ?&Lexer {
	return &Lexer{
		file_path: ''
		content: content
	}
}

pub fn (mut l Lexer) lex() []token.Token {
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
			char_lf { // newline
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

	return l.tokens
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

[inline]
fn (mut l Lexer) skip_whitespace() {
	for {
		look_char := l.look_char()

		if look_char == ` ` || look_char == `\t` {
			l.read_char()
		} else {
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
	value_string := match value {
		string {
			value
		}
		u8 {
			unsafe { value.vstring() }
		}
	}

	return token.new_token(kind, value_string)
}
