import { DateBlockStatement } from '../../ast/index.js';
import parseDateRecordsExpression from '../expressions/date-records-expression.js';

export default function parseDateBlockStatement(parser) {
    const statement = new DateBlockStatement();
    statement.token = parser.currentToken;

    parser.readToken(); // move currentToken to next token

    statement.value = parseDateRecordsExpression(parser);

    return statement;
}
