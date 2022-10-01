export default function generateDateRecordExpression(generator, node, env) {
    const receipts = [];

    for(const v of node.values) {
        const receipt = generator.produce(v, env);

        receipts.push(receipt);
    }

    return receipts;
}
