import { TokenKind } from '../token.js';

import parseConfigStatement from './statements/config-statement.js';

import parseIdentifierExpression from './expressions/identifier-expression.js';

const statementParsers = {
    [TokenKind.Config] : parseConfigStatement,
}

const expressionParsers = {
    [TokenKind.Identifier]: parseIdentifierExpression,
}

export {
    statementParsers,
    expressionParsers,
}
