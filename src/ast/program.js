import Node from './node.js';

class Program extends Node {

    statements = [];

    addStatement(statement) {
        this.statements.push(statement);
    }

    display() {
        let output = ['program {'];

        for(let i=0; i<this.statements.length; i++) {
            output.push(this.statements[i].display());
        }

        output.push('}');

        return output.join('\n');
    }

}

export default Program;
