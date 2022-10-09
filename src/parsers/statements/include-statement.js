import { TokenKind } from "../../token.js";
import { IncludeStatement } from "../../ast/index.js";
import parseStringExpression from "../expressions/string-expression.js";

export default function parseIncludeStatement(parser) {
    const nextToken = parser.lookNextToken();

    if (nextToken.kind !== TokenKind.String) {
        parser.throwUnexpectedToken("string", nextToken);
    }

    const statement = new IncludeStatement();

    statement.token = parser.currentToken;
    parser.readToken(); // move currentToken to string

    statement.path = parseStringExpression(parser);
    // skip call readToken() because it is called

    // collect include path
    parser.includes.push(statement.path);

    return statement;
}
