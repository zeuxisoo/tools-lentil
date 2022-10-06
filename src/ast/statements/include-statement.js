import Statement from '../statement.js';

class IncludeStatement extends Statement {

    token = {};
    path  = "";

    display() {
        let output = ['include "'];

        output.push(this.path.display());
        output.push('"');

        return output.join('');
    }

}

export default IncludeStatement;
