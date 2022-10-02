import { TokenKind } from '../../token.js';
import { DateRecordsExpression, DateRecordExpression, DateRecordReceiptExpression, AmountsExpression } from "../../ast/index.js";
import parseIdentifierExpression from './identifier-expression.js';
import parseAmountsExpression from './amounts-expression.js';
import parseAtomExpression from './atom-expression.js';
import parseTitleExpression from './title-expression.js';
import parseDescriptionExpression from './description-expression.js';

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

    switch(parser.currentToken.kind) {
        case TokenKind.Semicolon:
            expression.title       = parseTitleExpression(parser);
            expression.description = parseDescriptionExpression(parser);
            break;
        case TokenKind.Colon:
            expression.title       = parseAtomExpression(parser);
            expression.description = parseAtomExpression(parser);
            break;
        default:
            expression.title       = null;
            expression.description = null;
            break;
    }

    return expression;
}

function parseDateRecordReceiptExpression(parser) {
    const expression = new DateRecordReceiptExpression();
    expression.token = parser.currentToken;

    expression.account = parseIdentifierExpression(parser);
    parser.readToken();

    if ([TokenKind.Plus, TokenKind.Minus].includes(parser.currentToken.kind)) {
        expression.amounts = parseAmountsExpression(parser);
        parser.readToken();
    }else{
        const amountExpression  = new AmountsExpression();
        amountExpression.token  = parser.currentToken;
        amountExpression.values = [];

        expression.amounts = amountExpression;
    }

    return expression;
}
