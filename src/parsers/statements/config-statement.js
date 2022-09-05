import { TokenKind } from '../../token.js';
import { ConfigStatement } from '../../ast/index.js';
import parseConfigBlockStatement from './config-block-statement.js';

export default function parseConfigStatement(parser) {
    const nextToken = parser.lookNextToken();

    if (nextToken.kind !== TokenKind.LeftBrace) {
        parser.throwUnexpectedToken("{", nextToken);
    }

    parser.readToken(); // move currentToken to {
    parser.readToken(); // move currentToken to next token

    const statement = new ConfigStatement();
    statement.block = parseConfigBlockStatement(parser);

    return statement;
}
