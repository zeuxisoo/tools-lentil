module token

import regex

pub type TokenValue = string | u8

pub enum Kind {
	unknown
	end_of_line
	identifier
	literal
	left_brace // {
	right_brace // }
	assign // =
	left_bracket // [
	right_bracket // ]
	comma
	config // keywords
	account
}

const keywords = {
	'config': Kind.config
}

pub struct Token {
	kind  Kind
	value string
}

pub fn new_token(kind Kind, value string) Token {
	return Token{
		kind: kind
		value: value
	}
}

pub fn is_keyword(name string) bool {
	return name in token.keywords
}

pub fn is_account(name string) bool {
	// regex is not PCRE compatible. if need PCRE must install pcre modules
	// ref    : https://modules.vlang.io/regex.html
	// orignal: ^(Assets|Expenses|Liabilities|Equity|Income){1}(:[a-zA-Z]+)*
	mut re := regex.regex_opt(r'^((Assets)|(Expenses)|(Liabilities)|(Equity)|(Income)){1}(:[a-zA-Z]+)*') or {
		panic(err)
	}

	start, _ := re.find(name)

	return start == 0
}

pub fn find_keyword_kind(name string) Kind {
	return token.keywords[name]
}
