const TokenKind = {
    // Basic
    NewLine     : "\n",
    Assign      : "=",
    LeftBracket : "[",
    RightBracket: "]",
    LeftBrace   : "{",
    RightBrace  : "}",
    Comma       : ",",
    Plus        : "+",
    Minus       : "-",
    BitwiseAnd  : "&",
    Colon       : ":",
    Semicolon   : ";",
    Date        : "date",
    Title       : "title",
    Description : "description",
    Account     : "account",
    Atom        : "atom",
    Identifier  : "identifier",
    String      : "string",
    Number      : "number",
    Eof         : "eof",

    // Keyword
    Config : "config",
    Include: "include",
}

const ReservedKeywords = {
    'config' : TokenKind.Config,
    'include': TokenKind.Include,
};

export {
    TokenKind,
    ReservedKeywords
}
