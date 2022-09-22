import Expression from '../expression.js';

class DateRecordReceiptExpression extends Expression {

    token   = {};
    account = {};
    amount  = {};
    isLast  = false;

    display() {
        let output = [''];

        output.push(this.account.display());
        output.push(this.amount.display());
        output.push(this.isLast ? '$' : "");

        return output.join('');
    }

}

export default DateRecordReceiptExpression;