import Expression from '../expression.js';

class ArrayExpression extends Expression {

    token  = {};
    values = [];

    display() {
        let output = ['['];

        let elements = [];
        for(const v of this.values) {
            elements.push(v.display());
        }

        output.push(elements.join(','));
        output.push(']');

        return output.join('');
    }

}

export default ArrayExpression;
