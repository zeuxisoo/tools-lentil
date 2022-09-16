import Expression from '../expression.js';

class NumberKindExpression extends Expression {

    token = {};
    value = "";

    display() {
        return `${this.value}`;
    }

}

export default NumberKindExpression;
