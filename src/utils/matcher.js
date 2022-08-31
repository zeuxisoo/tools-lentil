function isWhiteSpace(value) {
    return value === ' ' || /\t/.test(value);
}

function isNewline(value) {
    return /[\n|\r|\r\n]/.test(value);
}

function isColon(value) {
    return value === ':';
}

function isAlpha(value) {
    return /^[a-zA-Z]$/.test(value);
}

function isDigit(value) {
    return /^[0-9]$/.test(value);
}

function isLiteral(value) {
    return /^[a-zA-Z_:]$/.test(value);
}

function isIdentifier(value) {
    return /^[a-zA-Z_]+$/.test(value);
}

function isAccount(value) {
    return /^(Assets|Expenses|Liabilities|Equity|Income){1}(:[a-zA-Z]+)*/.test(value);
}

function isString(value) {
    return typeof value === 'string';
}

export {
    isWhiteSpace,
    isNewline,
    isColon,
    isAlpha,
    isDigit,
    isLiteral,
    isIdentifier,
    isAccount,
    isString,
}
