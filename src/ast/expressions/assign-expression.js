import Expression from '../expression.js';

class AssignExpression extends Expression {

    token = {};
    left  = null;
    right = null;

    display() {
        return `${this.left.display()} = ${this.right.display()}`;
    }

}

export default AssignExpression;
