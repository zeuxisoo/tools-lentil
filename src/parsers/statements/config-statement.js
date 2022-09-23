import { TokenKind } from '../../token.js';
import { ConfigStatement } from '../../ast/index.js';
import parseConfigBlockStatement from './config-block-statement.js';

export default function parseConfigStatement(parser) {
    const nextToken = parser.lookNextToken();

    if (nextToken.kind !== TokenKind.LeftBrace) {
        parser.throwUnexpectedToken("{", nextToken);
    }

    const statement = new ConfigStatement();

    statement.token = parser.currentToken;
    parser.readToken(); // move currentToken to {

    statement.block = parseConfigBlockStatement(parser);
    // skip call readToken() because it is called

    return statement;
}
