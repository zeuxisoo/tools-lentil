export default function generateAmountsExpression(generator, node, env) {
    const amounts = [];

    for(const v of node.values) {
        const amount = generator.produce(v, env);

        amounts.push(amount);
    }

    return amounts;
}
