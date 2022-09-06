import { ArrayExpression } from "../../ast/index.js";

export default function parseArrayExpression(parser) {
    const expression  = new ArrayExpression();
    expression.token  = parser.currentToken;
    expression.values = parser.parseExpressionList();

    return expression;
}
