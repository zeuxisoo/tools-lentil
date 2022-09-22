import Expression from '../expression.js';

class TitleExpression extends Expression {

    token = {};
    value = "";

    display() {
        return `; ${this.value}`;
    }

}

export default TitleExpression;
