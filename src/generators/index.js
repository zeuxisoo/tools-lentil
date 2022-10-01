import {
    Program,
    ConfigStatement, ConfigBlockStatement,
    IdentifierExpression, ArrayExpression, StringExpression,
    AssignExpression, AccountExpression,
    AmountsExpression, AmountExpression,
    NumberExpression, NumberKindExpression,
    DateStatement, DateBlockStatement,
    DateRecordsExpression, DateRecordExpression, DateRecordReceiptExpression
} from '../ast/index.js';

import generateProgram from './program.js';

import generateConfigStatement from './config-statements.js';
import generateConfigBlockStatement from './config-block-statement.js';

import generateIdentifierExpression from './identifier-expression.js';
import generateArrayExpression from './array-expression.js';
import generateStringExpression from './string-expression.js';
import generateAssignExpression from './assign-expression.js';
import generateAccountExpression from './account-expression.js';

import generateAmountsExpression from './amounts-expression.js';
import generateAmountExpression from './amount-expression.js';

import generateNumberExpression from './number-expression.js';
import generateNumberKindExpression from './number-kind-expression.js';

import generateDateStatement from './date-statement.js';
import generateDateBlockStatement from './date-block-statement.js';
import generateDateRecordsExpression from './date-records-expression.js';
import generateDateRecordExpression from './date-record-expression.js';
import generateDateRecordReceiptExpression from './date-record-receipt-expression.js';

const generators = {
    [Program]             : generateProgram,
    [ConfigStatement]     : generateConfigStatement,
    [ConfigBlockStatement]: generateConfigBlockStatement,
    [IdentifierExpression]: generateIdentifierExpression,
    [ArrayExpression]     : generateArrayExpression,
    [StringExpression]    : generateStringExpression,
    [AssignExpression]    : generateAssignExpression,
    [AccountExpression]   : generateAccountExpression,

    [AmountsExpression]   : generateAmountsExpression,
    [AmountExpression]    : generateAmountExpression,

    [NumberExpression]    : generateNumberExpression,
    [NumberKindExpression]: generateNumberKindExpression,

    [DateStatement]              : generateDateStatement,
    [DateBlockStatement]         : generateDateBlockStatement,
    [DateRecordsExpression]      : generateDateRecordsExpression,
    [DateRecordExpression]       : generateDateRecordExpression,
    [DateRecordReceiptExpression]: generateDateRecordReceiptExpression,
};

export {
    generators
}
