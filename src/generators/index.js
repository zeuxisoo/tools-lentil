import {
    Program,
    ConfigStatement, ConfigBlockStatement,
    IdentifierExpression, ArrayExpression, StringExpression,
} from '../ast/index.js';

import generateProgram from './program.js';

import generateConfigStatement from './config-statements.js';
import generateConfigBlockStatement from './config-block-statement.js';

import generateIdentifierExpression from './identifier-expression.js';
import generateArrayExpression from './array-expression.js';
import generateStringExpression from './string-expression.js';

const generators = {
    [Program]             : generateProgram,
    [ConfigStatement]     : generateConfigStatement,
    [ConfigBlockStatement]: generateConfigBlockStatement,
    [IdentifierExpression]: generateIdentifierExpression,
    [ArrayExpression]     : generateArrayExpression,
    [StringExpression]    : generateStringExpression,
};

export {
    generators
}
