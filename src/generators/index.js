import {
    Program,
    ConfigStatement, ConfigBlockStatement,
    IdentifierExpression, ArrayExpression, StringExpression,
    AssignExpression, AccountExpression,
} from '../ast/index.js';

import generateProgram from './program.js';

import generateConfigStatement from './config-statements.js';
import generateConfigBlockStatement from './config-block-statement.js';

import generateIdentifierExpression from './identifier-expression.js';
import generateArrayExpression from './array-expression.js';
import generateStringExpression from './string-expression.js';
import generateAssignExpression from './assign-expression.js';
import generateAccountExpression from './account-expression.js';

const generators = {
    [Program]             : generateProgram,
    [ConfigStatement]     : generateConfigStatement,
    [ConfigBlockStatement]: generateConfigBlockStatement,
    [IdentifierExpression]: generateIdentifierExpression,
    [ArrayExpression]     : generateArrayExpression,
    [StringExpression]    : generateStringExpression,
    [AssignExpression]    : generateAssignExpression,
    [AccountExpression]   : generateAccountExpression,
};

export {
    generators
}
