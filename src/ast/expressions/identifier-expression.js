import Expression from '../expression.js';

class IdentifierExpression extends Expression {

    token = {};
    value = "";

    display() {
        return `${this.value}`;
    }

}

export default IdentifierExpression;
