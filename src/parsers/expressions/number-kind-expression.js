import { NumberKindExpression } from "../../ast/index.js";

export default function parseNumberKindExpression(parser) {
    const expression = new NumberKindExpression();
    expression.token = parser.currentToken;
    expression.value = parser.currentToken.value;

    return expression;
}
