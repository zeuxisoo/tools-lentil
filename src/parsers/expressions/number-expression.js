import { NumberExpression } from "../../ast/index.js";

export default function parseNumberExpression(parser) {
    const expression = new NumberExpression();
    expression.token = parser.currentToken;
    expression.value = parser.currentToken.value;

    return expression;
}
