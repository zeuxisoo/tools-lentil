import { AccountExpression } from "../../ast/index.js";
import { findKind } from "../../utils/account.js";

export default function parseAccountExpression(parser) {
    const expression = new AccountExpression();
    expression.token = parser.currentToken;
    expression.value = parser.currentToken.value;
    expression.kind  = findKind(expression.value);

    return expression;
}
