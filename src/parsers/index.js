import { TokenKind } from '../token.js';

import parseConfigStatement from './statements/config-statement.js';

import parseIdentifierExpression from './expressions/identifier-expression.js';
import parseArrayExpression from './expressions/array-expression.js';
import parseStringExpression from './expressions/string-expression.js';
import parseAccountExpression from './expressions/account-expression.js';

const statementParsers = {
    [TokenKind.Config] : parseConfigStatement,
}

const expressionStatementParsers = {
    [TokenKind.Identifier] : parseIdentifierExpression,
}

const expressionParsers = {
    [TokenKind.LeftBracket]: parseArrayExpression,
    [TokenKind.String]     : parseStringExpression,
    [TokenKind.Account]    : parseAccountExpression,
}

export {
    statementParsers,
    expressionStatementParsers,
    expressionParsers,
}
