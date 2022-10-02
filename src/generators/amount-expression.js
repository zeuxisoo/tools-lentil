export default function generateAmountExpression(generator, node, env) {
    const price    = generator.produce(node.value);
    const currency = generator.produce(node.currency);

    if (!env.configs.currency.includes(currency)) {
        generator.throwCurrencyNotFoundException(currency);
    }

    return {
        price,
        currency
    };
}
