import Expression from '../expression.js';

class StringExpression extends Expression {

    token = {};
    value = "";

    display() {
        return `${this.value}`;
    }

}

export default StringExpression;
