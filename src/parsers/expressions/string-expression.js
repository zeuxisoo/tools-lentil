import { StringExpression } from "../../ast/index.js";

export default function parseStringExpression(parser) {
    const expression = new StringExpression();
    expression.token = parser.currentToken;
    expression.value = parser.currentToken.value;

    return expression;
}
