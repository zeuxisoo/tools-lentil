module lexer

import os
import token

const (
	char_eof = u8(C.EOF)
)

pub struct Lexer {
	file_path string
mut:
	content          string
	content_length   int
	current_position int
	current_line     int
	current_column   int
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
		content_length: content.len
		current_line: 1
		current_column: 0
	}
}

pub fn new_lexer_content(content string) ?&Lexer {
	return &Lexer{
		file_path: ''
		content: content
		content_length: content.len
		current_line: 1
		current_column: 0
	}
}

pub fn (mut l Lexer) lex() []token.Token {
	for l.current_position < l.content_length {
		look_char := l.look_char()

		// skip newline, whitespace
		if (look_char == `\n` || look_char == `\r`) || (look_char == ` ` || look_char == `\t`) {
			l.read_char()
			continue
		}

		// skip single line comemnt
		if look_char == `/` && l.look_next_char() == `/` {
			l.skip_single_line_comment()
			continue
		}

		// tokens
		token := l.lex_text(look_char) or {
			eprintln(err)
			exit(1)
		}

		l.tokens << token
	}

	return l.tokens
}

fn (mut l Lexer) lex_text(look_char u8) ?token.Token {
	return match look_char {
		`{` {
			l.new_token(.left_brace, l.read_char())
		}
		`}` {
			l.new_token(.right_brace, l.read_char())
		}
		`=` {
			l.new_token(.assign, l.read_char())
		}
		`[` {
			l.new_token(.left_bracket, l.read_char())
		}
		`]` {
			l.new_token(.right_bracket, l.read_char())
		}
		`"` {
			l.new_token(.literal, l.read_string())
		}
		`,` {
			l.new_token(.comma, l.read_char())
		}
		lexer.char_eof {
			l.new_token(.end_of_line, 'eof')
		}
		else {
			if look_char.is_letter() {
				identifier := l.read_identifer()

				if token.is_keyword(identifier) {
					l.new_token(token.find_keyword_kind(identifier), identifier)
				} else if token.is_account(identifier) {
					account := l.read_account(identifier)

					l.new_token(.account, account)
				} else {
					l.new_token(.identifier, identifier)
				}
			} else if look_char.is_digit() {
				old_status := {
					'position': l.current_position
					'line':     l.current_line
					'column':   l.current_column
				}

				date := l.read_date()

				if token.is_date(date) {
					l.new_token(.date, date)
				} else {
					l.current_position = old_status['position']
					l.current_line = old_status['inline']
					l.current_column = old_status['column']

					l.new_token(.number, l.read_number())
				}
			} else {
				unknown_char := unsafe { look_char.vstring() }

				error('unknown char: `$unknown_char` in (line: $l.current_line, column: $l.current_column)')
			}
		}
	}
}

fn (mut l Lexer) look_char() u8 {
	current_position := l.current_position

	if current_position < l.content.len {
		return l.content[current_position]
	}

	return lexer.char_eof
}

fn (mut l Lexer) look_next_char() u8 {
	current_position := l.current_position + 1

	if current_position < l.content.len {
		return l.content[current_position]
	}

	return lexer.char_eof
}

fn (mut l Lexer) read_char() u8 {
	current_char := l.content[l.current_position]

	if current_char == `\n` || current_char == `\r` {
		l.current_line = l.current_line + 1
		l.current_column = 0
	}

	l.current_position = l.current_position + 1
	l.current_column = l.current_column + 1

	return current_char
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

fn (mut l Lexer) read_string() string {
	l.read_char() // skip start `"`

	mut value := []u8{}

	for {
		look_char := l.look_char()

		if look_char == `\\` {
			l.read_char()
		}

		if look_char != `"` {
			value << l.read_char()
		} else {
			l.read_char() // skip last `"`
			break
		}

		l.check_end_of_file('read_string')
	}

	return value.bytestr()
}

fn (mut l Lexer) read_number() string {
	mut value := []u8{}

	for {
		look_char := l.look_char()

		if look_char.is_digit() || look_char == `.` {
			value << l.read_char()
		} else {
			break
		}
	}

	return value.bytestr()
}

fn (mut l Lexer) read_account(prefix string) string {
	mut value := []u8{}

	for {
		look_char := l.look_char()

		if look_char.is_letter() || look_char == `:` {
			value << l.read_char()
		} else {
			break
		}
	}

	return prefix + value.bytestr()
}

fn (mut l Lexer) read_date() string {
	mut value := []u8{}

	for {
		look_char := l.look_char()

		if look_char.is_digit() || look_char == `-` {
			value << l.read_char()
		} else {
			break
		}
	}

	return value.bytestr()
}

[inline]
fn (mut l Lexer) skip_single_line_comment() {
	// skip the double slash
	l.read_char()
	l.read_char()

	for l.look_char() != `\n` && l.look_char() != `\r` {
		l.read_char()
	}
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

fn (mut l Lexer) check_end_of_file(method_name string) {
	if l.current_position >= l.content_length {
		panic('cannot read next char, got end of file in `$method_name` method')
	}
}
