export default function generateDateStatement(generator, node, env) {
    const date = node.value;
    const rows = generator.produce(node.block, env);

    const content = [];
    const recordPrefixWhitespace = ' '.repeat(4);

    for(const row of rows) {
        // Date
        content.push(date);

        // Date records
        for(const record of row) {
            content.push(`${recordPrefixWhitespace}${record}`);
        }
    }

    return content.join('\n');
}
