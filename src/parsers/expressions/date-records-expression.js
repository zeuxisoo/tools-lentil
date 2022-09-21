import { TokenKind } from '../../token.js';
import { DateRecordsExpression, DateRecordExpression, DateRecordReceiptExpression } from "../../ast/index.js";
import parseIdentifierExpression from './identifier-expression.js';
import parseNumberKindExpression from './number-kind-expression.js';
import parseNumberExpression from './number-expression.js';
import parseAtomExpression from './atom-expression.js';

export default function parseDateRecordsExpression(parser) {
    const expression  = new  DateRecordsExpression();
    expression.token  = parser.currentToken;
    expression.values = [];

    while(![TokenKind.RightBrace, TokenKind.Eof].includes(parser.currentToken.kind)) {

        const record = parseDateRecordExpression(parser);

        expression.values.push(record);

    }

    return expression;
}

function parseDateRecordExpression(parser) {
    const expression  = new DateRecordExpression();
    expression.token  = parser.currentToken;
    expression.values = [
        parseDateRecordReceiptExpression(parser)
    ];

    while(parser.currentToken.kind === TokenKind.BitwiseAnd) {
        if (parser.currentToken.kind === TokenKind.BitwiseAnd) {
            parser.readToken();
        }

        const receipt = parseDateRecordReceiptExpression(parser);

        expression.values.push(receipt);
    }

    expression.values[expression.values.length - 1].isLast = true;

    return expression;
}

function parseDateRecordReceiptExpression(parser) {
    const expression = new DateRecordReceiptExpression();
    expression.token = parser.currentToken;

    expression.account = parseIdentifierExpression(parser);
    parser.readToken();

    if ([TokenKind.Plus, TokenKind.Minus].includes(parser.currentToken.kind)) {
        expression.kind = parseNumberKindExpression(parser);
        parser.readToken();

        expression.amount = parseNumberExpression(parser);
        parser.readToken();

        expression.currency = parseIdentifierExpression(parser);
        parser.readToken();
    }

    expression.title       = parseAtomExpression(parser);
    expression.description = parseAtomExpression(parser);

    return expression;
}
