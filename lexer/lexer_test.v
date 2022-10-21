module lexer

import token

fn test_config() {
	tokens := create_tokens('config{}')!

	assert tokens.len == 3
	assert tokens == [
		token.new_token(.config, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
	]
}

fn test_config_assign() {
	tokens := create_tokens('config{
		currency = ["hkd", "usd"]
	}')!

	assert tokens.len == 10
	assert tokens == [
		token.new_token(.config, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.identifier, 'currency'),
		token.new_token(.assign, '='),
		token.new_token(.left_bracket, '['),
		token.new_token(.literal, 'hkd'),
		token.new_token(.comma, ','),
		token.new_token(.literal, 'usd'),
		token.new_token(.right_bracket, ']'),
		token.new_token(.right_brace, '}'),
	]
}

fn test_skip_whitespace() {
	tokens := create_tokens('config {    			}')!

	assert tokens.len == 3
	assert tokens == [
		token.new_token(.config, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
	]
}

fn test_skip_newline() {
	tokens := create_tokens('config {
		foo   bar	baz
		quz
	}')!

	assert tokens.len == 7
	assert tokens == [
		token.new_token(.config, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.identifier, 'foo'),
		token.new_token(.identifier, 'bar'),
		token.new_token(.identifier, 'baz'),
		token.new_token(.identifier, 'quz'),
		token.new_token(.right_brace, '}'),
	]
}

fn test_skip_single_line_comment() {
	tokens := create_tokens('
		// comment 1
		config {}
		config {} // comment 2
		config {
			// comment 3
		}

		key = value // comment 4
	')!

	assert tokens.len == 12
	assert tokens == [
		token.new_token(.config, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
		token.new_token(.config, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
		token.new_token(.config, 'config'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
		token.new_token(.identifier, 'key'),
		token.new_token(.assign, '='),
		token.new_token(.identifier, 'value'),
	]
}

fn test_assign_account() {
	tokens := create_tokens('
		aBank = Assets:Bank:ABank
		eShop = Expenses:Online:Shop
		lBank = Liabilities:Bank:LBank
		eWater= Equity:Unknown:Water
		iAbcd = Income:Salary:Abcd

	')!

	assert tokens.len == 15
	assert tokens == [
		token.new_token(.identifier, 'aBank'),
		token.new_token(.assign, '='),
		token.new_token(.account, 'Assets:Bank:ABank'),
		token.new_token(.identifier, 'eShop'),
		token.new_token(.assign, '='),
		token.new_token(.account, 'Expenses:Online:Shop'),
		token.new_token(.identifier, 'lBank'),
		token.new_token(.assign, '='),
		token.new_token(.account, 'Liabilities:Bank:LBank'),
		token.new_token(.identifier, 'eWater'),
		token.new_token(.assign, '='),
		token.new_token(.account, 'Equity:Unknown:Water'),
		token.new_token(.identifier, 'iAbcd'),
		token.new_token(.assign, '='),
		token.new_token(.account, 'Income:Salary:Abcd'),
	]
}

fn create_tokens(content string) ![]token.Token {
	mut lexer := new_lexer_content(content) or { panic(err) }

	return lexer.lex()
}
