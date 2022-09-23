import { TokenKind } from "../../token.js";
import { AtomExpression } from "../../ast/index.js";

export default function parseAtomExpression(parser) {
    if (parser.currentToken.kind !== TokenKind.Colon) {
        return null;
    }

    const expression = new AtomExpression();

    expression.token = parser.currentToken;
    parser.readToken();

    expression.value = parser.currentToken.value;
    parser.readToken();

    return expression;
}
