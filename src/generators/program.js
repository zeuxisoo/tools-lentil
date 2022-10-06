export default function generateProgram(generator, node, env) {
    // add program root
    env.addProgram('root', node.root);

    // store generated codes
    let codes = [];

    for(const statement of node.statements) {
        const result = generator.produce(statement, env);

        if (result !== null) {
            codes.push(result);
        }
    }

    return codes;
}
