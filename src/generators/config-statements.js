export default function generateConfigStatement(generator, node, env) {
    return generator.produce(node.block, env);
}
