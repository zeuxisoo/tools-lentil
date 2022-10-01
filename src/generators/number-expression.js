export default function generateNumberExpression(generator, node, env) {
    const kind  = generator.produce(node.kind);
    const value = node.value;

    return `${kind}${value}`;
}
