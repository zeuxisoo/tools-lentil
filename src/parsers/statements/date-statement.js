import { TokenKind } from '../../token.js';
import { DateStatement } from '../../ast/index.js';
import parserDateBlockStatement from './date-block-statement.js';

export default function parseDateStatement(parser) {
    if (parser.currentToken.kind !== TokenKind.Date) {
        parser.throwUnexpectedToken("YYYY-mm-dd", parser.currentToken);
    }

    const statement   = new DateStatement();
    statement.token = parser.currentToken;

    statement.value = parser.currentToken.value;
    parser.readToken(); // move currentToken to {

    statement.block = parserDateBlockStatement(parser);
    // skip call readToken() because it is called

    return statement;
}
