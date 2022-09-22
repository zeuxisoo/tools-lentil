import TitleExpression from './title-expression.js';
import Expression from '../expression.js';

class DateRecordExpression extends Expression {

    token       = {};
    values      = [];
    title       = {};
    description = {};

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

        if (this.title) {
            output.push(' ' + this.title.display());
        }

        if (this.description) {
            if (!this.title instanceof TitleExpression) {
                output.push(' ');
            }

            output.push(this.description.display());
        }

        return output.join('');
    }

}

export default DateRecordExpression;
