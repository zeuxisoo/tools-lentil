export default function generateDateStatement(generator, node, env) {
    const date = node.value;
    const rows = generator.produce(node.block, env);

    const content = [];

    for(const row of rows) {
        // Date
        content.push(date);

        // Date records
        content.push(generateDate(row));
    }

    return content.join('\n');
}

function generateDate(recordRow) {
    let remainAmount = { price: 0, currency: '' };

    // Create render structure
    const records = [];

    for(const record of recordRow) {
        const amount = record.isLast
            ? generateRemainAmount(record.amount, remainAmount)
            : generateAmount(record.amount, remainAmount)

        records.push({
            recordPrefix : ' '.repeat(4),
            account      : record.account,
            accountSuffix: ' '.repeat(record.whitespace),
            amount       : amount,
        });
    }

    // Output the formatted structure
    // '+10.00 jpy'.length
    const lastAmountLength = records[records.length - 1].amount.length;

    const output = [];

    for(const record of records) {
        output.push(record.recordPrefix);
        output.push(record.account);
        output.push(record.accountSuffix);

        // Format amount in same width
        // Get the first amount length: `+10.00 usd @@ +7.80 xyz` -> `+10.00 usd`.length
        const amountLength = record.amount.match(/^[+|-][0-9]+\.[0-9]{2}\s[a-z]{3}/g)[0].length;
        const amountPrefix = record.isLast ? 0 : lastAmountLength - amountLength;

        output.push(' '.repeat(amountPrefix));
        output.push(record.amount);

        // Add newline when end of record
        output.push('\n');
    }

    return output.join('');
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
