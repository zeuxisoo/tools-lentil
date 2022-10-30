module lexer

import token

fn test_include() {
	tokens := create_tokens('include "dummy.tin"')!

	assert tokens.len == 2
	assert tokens == [
		token.new_token(.include, 'include'),
		token.new_token(.literal, 'dummy.tin'),
	]
}

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

fn test_skip_single_line_comment_only_comment() {
	tokens := create_tokens('// comment 1')!

	assert tokens.len == 0
	assert tokens == []
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

fn test_date_and_number() {
	tokens := create_tokens('
		2022-10-23 {}
		2022-10-23 {
		}

		1 5.5 10.10 20
	')!

	assert tokens.len == 10
	assert tokens == [
		token.new_token(.date, '2022-10-23'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
		token.new_token(.date, '2022-10-23'),
		token.new_token(.left_brace, '{'),
		token.new_token(.right_brace, '}'),
		token.new_token(.number, '1'),
		token.new_token(.number, '5.5'),
		token.new_token(.number, '10.10'),
		token.new_token(.number, '20'),
	]
}

fn test_date_records() {
	tokens := create_tokens('
		supermarket+25hkd & hosting+10usd,+78.50hkd & ocard-8.98inr & tbank
	')!

	assert tokens.len == 20
	assert tokens == [
		token.new_token(.identifier, 'supermarket'),
		token.new_token(.plus, '+'),
		token.new_token(.number, '25'),
		token.new_token(.identifier, 'hkd'),
		token.new_token(.bit_wise_and, '&'),
		token.new_token(.identifier, 'hosting'),
		token.new_token(.plus, '+'),
		token.new_token(.number, '10'),
		token.new_token(.identifier, 'usd'),
		token.new_token(.comma, ','),
		token.new_token(.plus, '+'),
		token.new_token(.number, '78.50'),
		token.new_token(.identifier, 'hkd'),
		token.new_token(.bit_wise_and, '&'),
		token.new_token(.identifier, 'ocard'),
		token.new_token(.minus, '-'),
		token.new_token(.number, '8.98'),
		token.new_token(.identifier, 'inr'),
		token.new_token(.bit_wise_and, '&'),
		token.new_token(.identifier, 'tbank'),
	]
}

fn test_date_records_title_description() {
	tokens := create_tokens('
		supermarket+25inr,+25hkd & hosting+10inr & tbank-35hkd :title :description
	')!

	assert tokens.len == 20
	assert tokens == [
		token.new_token(.identifier, 'supermarket'),
		token.new_token(.plus, '+'),
		token.new_token(.number, '25'),
		token.new_token(.identifier, 'inr'),
		token.new_token(.comma, ','),
		token.new_token(.plus, '+'),
		token.new_token(.number, '25'),
		token.new_token(.identifier, 'hkd'),
		token.new_token(.bit_wise_and, '&'),
		token.new_token(.identifier, 'hosting'),
		token.new_token(.plus, '+'),
		token.new_token(.number, '10'),
		token.new_token(.identifier, 'inr'),
		token.new_token(.bit_wise_and, '&'),
		token.new_token(.identifier, 'tbank'),
		token.new_token(.minus, '-'),
		token.new_token(.number, '35'),
		token.new_token(.identifier, 'hkd'),
		token.new_token(.atom, 'title'),
		token.new_token(.atom, 'description'),
	]
}
