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

function isCJK(value) {
    return /[\u4E00-\u9FCC]/.test(value);
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
    isCJK,
}
