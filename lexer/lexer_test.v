module lexer

import token

fn test_config() {
	tokens := create_tokens('config{}')!

	assert tokens.len == 3
	assert tokens == [
		token.new_token(.identifier, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
	]
}

fn test_skip_whitespace() {
	tokens := create_tokens('config {    			}')!

	assert tokens.len == 3
	assert tokens == [
		token.new_token(.identifier, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
	]
}

fn test_skip_newline() {
	tokens := create_tokens('config {
		foo   bar	baz   quz
	}')!

	assert tokens.len == 7
	assert tokens == [
		token.new_token(.identifier, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.identifier, 'foo'),
		token.new_token(.identifier, 'bar'),
		token.new_token(.identifier, 'baz'),
		token.new_token(.identifier, 'quz'),
		token.new_token(.right_brace, '}'),
	]
}

fn create_tokens(content string) ![]token.Token {
	mut lexer := new_lexer_content(content) or { panic(err) }

	return lexer.lex()
}
