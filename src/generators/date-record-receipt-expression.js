export default function generateDateRecordReceiptExpression(generator, node, env) {
    const accountName  = generator.produce(node.account, env);
    const accountValue = env.variables[accountName];

    if (accountValue === null) {
        generator.throwAccountNotFoundException(accountName);
    }

    // Calculate whitespace between account and currency
    const accountLength    = Object.values(env.variables).reduce((a, b) => a > b ? a : b).length;
    const whitespaceLength = accountLength - accountValue.length + 4;                                // fix 4 space

    // Input amount by manually
    const amount = node.amounts.values.length > 0 ? generator.produce(node.amounts, env) : [];

    //
    return {
        account   : accountValue,
        amount    : amount,
        isLast    : node.isLast,
        whitespace: whitespaceLength,
    };
}
