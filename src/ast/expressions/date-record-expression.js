import Expression from '../expression.js';

class DateRecordExpression extends Expression {

    token  = {};
    values = [];

    display() {
        let output = ['['];

        let subOutput = [];
        for(const v of this.values) {
            if (v !== null) {
                subOutput.push(v.display());
            }
        }

        output.push(subOutput.join(' & '));
        output.push(']');

        return output.join('');
    }

}

export default DateRecordExpression;
