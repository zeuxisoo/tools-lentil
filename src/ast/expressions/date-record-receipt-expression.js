import Expression from '../expression.js';

class DateRecordReceiptExpression extends Expression {

    token   = {};
    account = {};
    amounts = {}; // AmountsExpression
    isLast  = false;

    display() {
        let output = [];

        output.push(this.account.display());

        if (this.amounts !== null) {
            output.push(this.amounts.display());
        }

        output.push(this.isLast ? '$' : "");

        return output.join('');
    }

}

export default DateRecordReceiptExpression;
