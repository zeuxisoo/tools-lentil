export default function generateProgram(generator, node, env) {
    // store generated codes
    let codes = [];

    for(const statement of node.statements) {
        const result = generator.produce(statement, env);

        if (result) {
            codes.push(result);
        }
    }

    return codes;
}
