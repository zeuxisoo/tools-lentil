function isWhiteSpace(value) {
    return value === ' ' || /\t/.test(value);
}

function isNewline(value) {
    return /[\n|\r|\r\n]/.test(value);
}

function isColon(value) {
    return /:/.test(value);
}

function isAlpha(value) {
    return /^[a-zA-Z]$/.test(value);
}

function isDigi(value) {
    return /^[0-9]$/.test(value);
}

function isIdentifier(value) {
    return /^[a-z]$/.test(value);
}

function isAccount(value) {
    return /^[A-Z]$/.test(value);
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
    isIdentifier,
    isAccount,
    isCJK,
}
