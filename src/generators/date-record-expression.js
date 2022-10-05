export default function generateDateRecordExpression(generator, node, env) {
    // Receipts
    const receipts = [];

    for(const v of node.values) {
        const receipt = generator.produce(v, env);

        receipts.push(receipt);
    }

    // Atom title
    const title = node.title === null ? "" : generator.produce(node.title);

    return {
        receipts,
        title,
    };
}
