export default function generateDateStatement(generator, node, env) {
    const date = node.value;
    const rows = generator.produce(node.block, env);

    const content = [];
    const recordPrefixWhitespace = ' '.repeat(4);

    for(const row of rows) {
        // Date
        content.push(date);

        // Date records
        const rowContent = [];

        // Store auto calculated remain amount value
        let remainAmount = { price: 0, currency: '' };

        for(const record of row) {
            rowContent.push(recordPrefixWhitespace);
            rowContent.push(record.account);
            rowContent.push(' '.repeat(record.whitespace));

            // Amount
            const amount = record.amount;

            if (!record.isLast) {
                switch(amount.length) {
                    case 1:
                        remainAmount = updateRemainAmount(remainAmount, amount[0]);

                        rowContent.push(concatAmount(amount[0]));
                        break;
                    case 2:
                        remainAmount = updateRemainAmount(remainAmount, amount[1]);

                        const first = concatAmount(amount[0]);
                        const second = concatAmount(amount[1]);

                        rowContent.push(`${first} @@ ${second}`);
                        break;
                }
            }else{
                // When amount is empty in last record, use the auto calculated remain amount
                if (amount.length <= 0) {
                    if (remainAmount.price > 0) {
                        remainAmount.price = `+${remainAmount.price}`;
                    }

                    rowContent.push(concatAmount(remainAmount));
                }else{
                    rowContent.push(concatAmount(amount[0]));
                }
            }

            // Add new when end of record
            rowContent.push('\n');
        }

        content.push(rowContent.join(''));
    }

    return content.join('\n');
}

function concatAmount(amount) {
    return `${amount.price} ${amount.currency}`;
}

function updateRemainAmount(remainAmount, amount) {
    remainAmount.price    += new Number(amount.price);
    remainAmount.currency  = amount.currency;

    return remainAmount;
}
