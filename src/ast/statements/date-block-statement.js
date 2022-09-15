import Statement from '../statement.js';

class DateBlockStatement extends Statement {

    token  = {};
    values = [];

    display() {
        let output = ['date_block {'];

        for(const v of this.values) {
            if (v !== null) {
                // output.push(v.display());
            }
        }

        output.push('}');

        return output.join('');
    }

}

export default DateBlockStatement;
