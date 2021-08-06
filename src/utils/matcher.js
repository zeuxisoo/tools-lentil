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

function isDigi(value) {
    return /^[0-9]$/.test(value);
}

function isLiteral(value) {
    return /^[a-zA-Z_:]$/.test(value);
}

function isIdentifier(value) {
    return /^[a-zA-Z_]+$/.test(value);
}

function isAccount(value) {
    return /^[Assets|Expenses|Liabilities|Equity|Income][:[a-zA-Z]+]*/.test(value);
}

function isCurrency(value) {
    return /^[hkd|usd|cny|jpy|eur|gbp|inr]+$/i.test(value);
}

function isString(value) {
    return typeof value === 'string';
}

export {
    isWhiteSpace,
    isNewline,
    isColon,
    isAlpha,
    isDigi,
    isLiteral,
    isIdentifier,
    isAccount,
    isCurrency,
    isString,
}
