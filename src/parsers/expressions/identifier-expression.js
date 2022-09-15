import { TokenKind } from "../../token.js";
import { IdentifierExpression } from "../../ast/index.js";
import parseAssignExpression from "./assign-expression.js";

export default function parseIdentifierExpression(parser) {
    const identifierExpression = new IdentifierExpression();
    identifierExpression.token = parser.currentToken;
    identifierExpression.value = parser.currentToken.value;

    if (parser.lookNextToken().kind === TokenKind.Assign) {
        return parseAssignExpression(parser, identifierExpression);
    }

    return identifierExpression;
}
