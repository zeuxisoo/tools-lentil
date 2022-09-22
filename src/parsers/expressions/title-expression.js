import { TokenKind } from "../../token.js";
import { TitleExpression } from "../../ast/index.js";

export default function parseTitleExpression(parser) {
    if (parser.currentToken.kind !== TokenKind.Semicolon) {
        return null;
    }

    const expression = new TitleExpression();
    expression.token = parser.currentToken;

    parser.readToken();

    expression.value = parser.currentToken.value;

    parser.readToken();

    return expression;
}
