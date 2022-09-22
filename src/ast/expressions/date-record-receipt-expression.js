import Expression from '../expression.js';

class DateRecordReceiptExpression extends Expression {

    token       = {};
    account     = {};
    kind        = {};
    amount      = {};
    currency    = {};
    isLast      = false;

    display() {
        let output = [''];

        output.push(this.account.value);
        output.push(this.kind.value);
        output.push(this.amount.value);
        output.push(this.currency.value);
        output.push(this.isLast ? '$' : "");

        return output.join('');
    }

}

export default DateRecordReceiptExpression;
