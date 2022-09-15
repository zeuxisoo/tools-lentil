import Statement from '../statement.js';

class DateStatement extends Statement {

    token = {};
    value = "";
    block = {};

    display() {
        let output = [`${this.value} {`];

        output.push(this.block.display());
        output.push('}');

        return output.join('');
    }

}

export default DateStatement;
