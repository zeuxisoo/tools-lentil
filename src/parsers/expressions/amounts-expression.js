import { TokenKind } from "../../token.js";
import { AmountsExpression } from "../../ast/index.js";
import parseAmountExpression from "./amount-expression.js";

export default function parseAmountsExpression(parser) {
    const expression = new AmountsExpression();
    expression.token = parser.currentToken;

    let amounts = [
        parseAmountExpression(parser)
    ];

    while(parser.lookNextToken().kind === TokenKind.Comma) {
        parser.readToken(); // move to comma

        if ([TokenKind.Plus, TokenKind.Minus].includes(parser.lookNextToken().kind)) {
            parser.readToken(); // move + / -

            const amount = parseAmountExpression(parser);

            amounts.push(amount);
        }
    }

    expression.values = amounts;

    return expression;
}
