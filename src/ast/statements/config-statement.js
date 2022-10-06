import Statement from '../statement.js';

class ConfigStatement extends Statement {

    token = {};
    block = null;

    display() {
        let output = ['config {'];

        output.push(this.block.display());
        output.push('}');

        return output.join('');
    }

}

export default ConfigStatement;
