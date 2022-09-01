const TokenKind = {
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
}

const ReservedKeywords = {
    'config': 'config',
};

export {
    TokenKind,
    ReservedKeywords
}
