import Expression from '../expression.js';

class AtomExpression extends Expression {

    token = {};
    value = '';

    display() {
        let output = [''];

        if (this.value.length > 0) {
            output.push(`:${this.value}`);
        }

        return output.join('');
    }

}

export default AtomExpression;
