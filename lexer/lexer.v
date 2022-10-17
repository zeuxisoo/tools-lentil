module lexer

import os

pub struct Lexer {
	file_path        string
	content          string
	current_column   int
	current_line     int
	current_position int
	current_char     rune
}

pub fn new_lexer(file_path string) ?&Lexer {
	if !os.is_file(file_path) {
		return error('file path is not file: $file_path')
	}

	content := os.read_file(file_path) or {
		return error('failed to open file: $file_path')
	}

	return &Lexer{
		file_path: file_path
		content: content
	}
}

pub fn (l Lexer) lex() {
	content_length := l.content.len_utf8()

	for i in 0..content_length {
		// TODO: match token
		println(l.content[i])
	}
}
