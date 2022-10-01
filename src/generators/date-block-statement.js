export default function generateDateBlockStatement(generator, node, env) {
    const record = generator.produce(node.value, env);

    return record;
}
