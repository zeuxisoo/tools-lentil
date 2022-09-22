import Expression from '../expression.js';

class NumberExpression extends Expression {

    token = {};
    kind  = {};
    value = "";

    display() {
        let output = [''];

        output.push(this.kind.display());
        output.push(this.value);

        return output.join('');
    }

}

export default NumberExpression;
