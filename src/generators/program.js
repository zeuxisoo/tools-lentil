export default function generateProgram(generator, node, env) {
    let codes = [];

    for(const statement of node.statements) {
        const result = generator.produce(statement, env);

        if (result !== null) {
            codes.push(result);
        }
    }

    return codes;
}
