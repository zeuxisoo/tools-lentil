import { DateBlockStatement } from '../../ast/index.js';

export default function parseDateBlockStatement(parser) {
    const statement = new DateBlockStatement();
    statement.token = parser.currentToken;
    statement.value = ""; // TODO: parse each records

    return statement;
}
