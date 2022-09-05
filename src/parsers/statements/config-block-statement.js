import { TokenKind } from '../../token.js';
import { ConfigBlockStatement } from '../../ast/index.js';

export default function parseConfigBlockStatement(parser) {
    const statement = new ConfigBlockStatement();

    while(parser.currentToken.kind !== TokenKind.RightBrace && parser.currentToken.kind !== TokenKind.Eof) {
        statement.values.push(parser.parseStatement());

        parser.readToken();
    }

    return statement;
}
