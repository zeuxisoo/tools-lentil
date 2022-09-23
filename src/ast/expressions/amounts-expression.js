import Expression from '../expression.js';

class AmountsExpression extends Expression {

    token  = {};
    values = [];

    display() {
        let output = [];

        for(const v of this.values) {
            output.push(v.display());
        }

        return output.join(',');
    }

}

export default AmountsExpression;
