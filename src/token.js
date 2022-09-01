const TokenKind = {
    // Basic
    NewLine     : "\n",
    Equals      : "=",
    LeftBracket : "[",
    RightBracket: "]",
    LeftBrace   : "{",
    RightBrace  : "}",
    DoubleQuote : "\"",
    Comma       : ",",
    Plus        : "+",
    Minus       : "-",
    BitwiseAnd  : "&",
    Semicolon   : ";",
    Date        : "date",
    Title       : "title",
    Description : "description",
    Account     : "account",
    Identifier  : "identifier",
    Number      : "number",
    Eof         : "eof",

    // Keyword
    Config: "config",
}

const ReservedKeywords = {
    'config': TokenKind.Config,
};

export {
    TokenKind,
    ReservedKeywords
}
