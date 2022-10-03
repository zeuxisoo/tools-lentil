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

        // Store auto calculated remain amount value, use in last record amount is empty
        let remainAmount = { price: 0, currency: '' };

        for(const record of row) {
            rowContent.push(recordPrefixWhitespace);
            rowContent.push(record.account);
            rowContent.push(' '.repeat(record.whitespace));

            // Amount
            const amount = record.amount;

            if (!record.isLast) {
                rowContent.push(generateAmount(amount, remainAmount));
            }else{
                rowContent.push(generateRemainAmount(amount, remainAmount));
            }

            // Add new when end of record
            rowContent.push('\n');
        }

        content.push(rowContent.join(''));
    }

    return content.join('\n');
}

function generateAmount(amount, remainAmount) {
    switch(amount.length) {
        case 1:
            remainAmount = updateRemainAmount(remainAmount, amount[0]);

            return concatAmount(amount[0]);
        case 2:
            remainAmount = updateRemainAmount(remainAmount, amount[1]);

            const first = concatAmount(amount[0]);
            const second = concatAmount(amount[1]);

            return `${first} @@ ${second}`;
    }
}

function generateRemainAmount(amount, remainAmount) {
    // When amount is empty in last record, use the auto calculated remain amount
    if (amount.length <= 0) {
        // when remain amount is positive, it should be add `-` prefix
        if (remainAmount.price > 0) {
            remainAmount.price = `-${remainAmount.price}`;
        }

        return concatAmount(remainAmount);
    }else{
        return concatAmount(amount[0]);
    }
}

function concatAmount(amount) {
    amount.price = new Number(amount.price).toFixed(2);

    if (amount.price > 0) {
        amount.price = `+${amount.price}`;
    }

    return `${amount.price} ${amount.currency}`;
}

function updateRemainAmount(remainAmount, amount) {
    remainAmount.price    += new Number(amount.price);
    remainAmount.currency  = amount.currency;

    return remainAmount;
}
