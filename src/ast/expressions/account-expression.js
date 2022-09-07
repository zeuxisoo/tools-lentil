import Expression from '../expression.js';

class AccountExpression extends Expression {

    token = {};
    value = "";
    kind  = ""; // assets | equity | expenses | income | liabilities

    display() {
        return `${this.value}`;
    }

}

export default AccountExpression;
