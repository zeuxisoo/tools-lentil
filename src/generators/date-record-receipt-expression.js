export default function generateDateRecordReceiptExpression(generator, node, env) {
    const accountName  = generator.produce(node.account, env);
    const accountValue = env.variables[accountName];

    if (accountValue === null) {
        generator.throwAccountNotFoundException(accountName);
    }

    //
    const accountLength = Object.values(env.variables).reduce((a, b) => a > b ? a : b).length;
    const whitespaceLength = accountLength - accountValue.length + 4; // fix 4 space
    const addWhitespace = ' '.repeat(whitespaceLength);

    // Input amount by manually
    const amount = node.amounts.values.length > 0 ? generator.produce(node.amounts, env) : null;

    if (amount === null) {
        return accountValue;
    }else{
        return `${accountValue}${addWhitespace}${amount}`;
    }
}
