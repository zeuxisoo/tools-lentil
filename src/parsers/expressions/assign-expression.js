import { TokenKind } from "../../token.js";
import { AssignExpression } from "../../ast/index.js";

export default function parseAssignExpression(parser, identifierExpression) {
    parser.readToken(); // move currentToken to =

    if (parser.currentToken.kind !== TokenKind.Assign) {
        parser.throwUnexpectedToken("=", parser.currentToken);
    }

    parser.readToken(); // move currentToken to right hand side

    const assignExpression = new AssignExpression();
    assignExpression.token = parser.currentToken;
    assignExpression.left  = identifierExpression;
    assignExpression.right = parser.parseExpression();

    return assignExpression;
}
