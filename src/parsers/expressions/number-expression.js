import { TokenKind } from "../../token.js";
import { NumberExpression } from "../../ast/index.js";
import parseNumberKindExpression from "./number-kind-expression.js";

export default function parseNumberExpression(parser) {
    if (![TokenKind.Plus, TokenKind.Minus].includes(parser.currentToken.kind)) {
        return null;
    }

    const expression = new NumberExpression();
    expression.token = parser.currentToken;

    expression.kind  = parseNumberKindExpression(parser);
    parser.readToken();

    expression.value = parser.currentToken.value;
    parser.readToken();

    return expression;
}
