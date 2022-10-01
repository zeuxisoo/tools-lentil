export default function generateAmountsExpression(generator, node, env) {
    const amounts = [];

    for(const v of node.values) {
        const amount = generator.produce(v, env);

        amounts.push(amount);
    }

    switch(amounts.length) {
        case 1:
            return amounts.join('');
        case 2:
            return amounts.join(' @@ ');
        default:
            generator.throwUnexpectedException(`amount length miss match, got ${amounts.length}, want 1 or 2`);
    }
}
