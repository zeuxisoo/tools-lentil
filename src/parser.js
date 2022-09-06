import {
    Program,
    ArrayExpression, StringExpression
} from './ast/index.js';
import { TokenKind } from './token.js';
import { ParseUnexpectedTokenException } from './exceptions/index.js';
import { statementParsers, expressionStatementParsers, expressionParsers  } from './parsers/index.js';

class Parser {

    constructor(lexer) {
        this.ast    = new Program();
        this.lexer  = lexer;
        this.tokens = [];

        this.currentToken = {};
    }

    parse() {
        // Get the tokens and initial the first current token value
        this.tokens = this.lexer.lex();

        this.readToken();

        while(this.tokens.length > 0) {
            const statement = this.parseStatement();

            if (statement !== null) {
                this.ast.addStatement(statement);
            }

            this.readToken();
        }

        console.log(this.ast.display());
    }

    // e.g. N expressions
    parseStatement() {
        const parser = statementParsers[this.currentToken.kind];

        const statement =  parser !== undefined
            ? parser(this)
            : this.parseExpressionStatement();

        return statement;
    }

    // e.g. a = b
    parseExpressionStatement() {
        const parser = expressionStatementParsers[this.currentToken.kind];

        const expressionStatement = parser !== undefined
            ? parser(this)
            : console.log('expressionStatement: ', this.currentToken);

        return expressionStatement;
    }

    // e.g. [a, b, c] / "abc"
    parseExpression() {
        const parser = expressionParsers[this.currentToken.kind];

        const expression = parser !== undefined
            ? parser(this)
            : console.log('expression: ', this.currentToken);

        return expression
    }

    // helpers
    parseExpressionList() {
        // move currentToken to next value, skip [ token
        this.readToken();

        let expressions = [];

        while(![TokenKind.RightBracket, TokenKind.Eof].includes(this.lookNextToken().kind)) {
            const expression = this.parseExpression();

            expressions.push(expression);

            this.readToken();

            // move currentToken to next value, skip , token
            if (this.currentToken.kind === TokenKind.Comma) {
                this.readToken();
            }
        }

        const lookNextToken = this.lookNextToken()

        if (lookNextToken.kind !== TokenKind.RightBracket) {
            this.throwUnexpectedToken("]", lookNextToken);
        }

        this.readToken();

        return expressions;
    }

    lookNextToken() {
        const nextToken = this.tokens.shift();

        this.tokens.unshift(nextToken);

        return nextToken;
    }

    readToken()  {
        this.currentToken = this.tokens.shift();
    }

    throwUnexpectedToken(want, token) {
        throw new ParseUnexpectedTokenException(want, token);
    }

}

function createParser(lexer) {
    return new Parser(lexer)
}

export {
    createParser
}
