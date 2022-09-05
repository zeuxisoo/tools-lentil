import { TokenKind } from '../token.js';

import parseConfigStatement from './statements/config-statement.js';

const statementParsers = {
    [TokenKind.Config] : parseConfigStatement,
}

export {
    statementParsers
}
