import { TokenKind } from "../../token.js";
import { DescriptionExpression } from "../../ast/index.js";

export default function parseDescriptionExpression(parser) {
    if (parser.currentToken.kind !== TokenKind.Colon) {
        return null;
    }

    const expression = new DescriptionExpression();

    expression.token = parser.currentToken;
    parser.readToken();

    expression.value = parser.currentToken.value;
    parser.readToken();

    return expression;
}
