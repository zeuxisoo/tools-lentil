import Statement from '../statement.js';

class ConfigBlockStatement extends Statement {

    token  = {};
    values = [];

    display() {
        let output = ['config_block {'];

        for(const v of this.values) {
            if (v !== null) {
                output.push(v.display());
            }
        }

        output.push('}');

        return output.join('');
    }

}

export default ConfigBlockStatement;
