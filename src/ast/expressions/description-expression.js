import Expression from '../expression.js';

class DescriptionExpression extends Expression {

    token = {};
    value = "";

    display() {
        return `:${this.value}`;
    }

}

export default DescriptionExpression;
