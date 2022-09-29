export default function generateArrayExpression(generator, node, env) {
    let items = [];

    for(const v of node.values) {
        items.push(generator.produce(v, env));
    }

    return items;
}
