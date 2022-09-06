import { TokenKind } from "../../token.js";
import { IdentifierExpression, AssignExpression } from "../../ast/index.js";

export default function parseIdentifierExpression(parser) {
    const nextToken = parser.lookNextToken();

    if (nextToken.kind !== TokenKind.Assign) {
        parser.throwUnexpectedToken("=", nextToken);
    }

    const identifierExpression = new IdentifierExpression();
    identifierExpression.token = parser.currentToken;
    identifierExpression.value = parser.currentToken.value;

    parser.readToken(); // move currentToken to =
    parser.readToken(); // move currentToken to right hand side

    const assignExpression = new AssignExpression();
    assignExpression.token = nextToken;
    assignExpression.left  = identifierExpression;
    assignExpression.right = parser.parseExpression();

    return assignExpression;
}
