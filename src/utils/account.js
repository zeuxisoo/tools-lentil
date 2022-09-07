function findKind(value) {
    return value.replace(/^(Assets|Equity|Expenses|Income|Liabilities|):.*/, "$1").toLowerCase();
}

export {
    findKind
}
