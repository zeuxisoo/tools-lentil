module token

pub type TokenValue = string | u8

pub enum Kind {
	unknown
	end_of_line
	identifier
	left_brace
	right_brace
}

pub struct Token {
	kind  Kind
	value string
}
