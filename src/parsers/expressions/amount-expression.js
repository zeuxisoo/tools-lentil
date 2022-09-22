import { AmountExpression } from "../../ast/index.js";
import parseNumberExpression from "./number-expression.js";
import parseIdentifierExpression from "./identifier-expression.js";

export default function parseAmountExpression(parser) {
    const expression = new AmountExpression();
    expression.token = parser.currentToken;

    expression.value = parseNumberExpression(parser);
    parser.readToken();

    expression.currency = parseIdentifierExpression(parser);

    return expression;
}
