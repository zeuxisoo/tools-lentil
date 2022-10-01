export default function generateDateRecordsExpression(generator, node, env) {
    let records = [];

    for(const v of node.values) {
        const record = generator.produce(v, env);

        records.push(record);
    }

    return records;
}
