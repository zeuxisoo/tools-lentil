import Expression from '../expression.js';

class DateRecordReceiptExpression extends Expression {

    token       = {};
    account     = {};
    kind        = {};
    amount      = {};
    currency    = {};
    title       = {};
    description = {};
    isLast      = false;

    display() {
        let output = [''];

        output.push(this.account.value);
        output.push(this.kind.value);
        output.push(this.amount.value);
        output.push(this.currency.value);
        output.push(this.isLast ? '$' : "");

        if (this.title) {
            output.push(' ' + this.title.display());
        }

        if (this.description) {
            output.push(' ' + this.description.display());
        }

        return output.join('');
    }

}

export default DateRecordReceiptExpression;
