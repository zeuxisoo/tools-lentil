module token

pub type TokenValue = string | u8

pub enum Kind {
	unknown
	end_of_line
	identifier
	left_brace // {
	right_brace // }
	assign // =
	left_bracket // [
	right_bracket // ]
	config // keywords
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

pub fn find_keyword_kind(name string) Kind {
	return token.keywords[name]
}
