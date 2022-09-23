import Expression from '../expression.js';

class AmountExpression extends Expression {

    token    = {};
    value    = []; // Number
    currency = {}; // Identifier

    display() {
        let output = [];

        output.push(this.value.display());
        output.push(this.currency.display());

        return output.join('');
    }

}

export default AmountExpression;
