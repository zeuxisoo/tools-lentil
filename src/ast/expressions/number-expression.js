import Expression from '../expression.js';

class NumberExpression extends Expression {

    token = {};
    value = "";

    display() {
        return `${this.value}`;
    }

}

export default NumberExpression;
