import Statement from '../statement.js';

class ConfigStatement extends Statement {

    block = null;

    display() {
        let output = ['config {'];

        output.push('block = ' + this.block.display());
        output.push('}');

        return output.join('');
    }

}

export default ConfigStatement;
