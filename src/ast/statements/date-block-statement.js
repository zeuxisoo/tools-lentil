import Statement from '../statement.js';

class DateBlockStatement extends Statement {

    token = {};
    value = {};

    display() {
        let output = ['date_block {'];

        output.push(this.value.display());
        output.push('}');

        return output.join('');
    }

}

export default DateBlockStatement;
