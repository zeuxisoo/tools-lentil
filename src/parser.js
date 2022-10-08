import path from 'path';
import { Program, File as AstFile } from './ast/index.js';
import { TokenKind } from './token.js';
import { ParseUnexpectedTokenException, ParseUnexpectedException } from './exceptions/index.js';
import { statementParsers, expressionStatementParsers, expressionParsers  } from './parsers/index.js';

class Parser {

    constructor(lexer, options) {
        const program = new Program();
        program.root = path.resolve(path.dirname(options.path));

        this.ast          = program;
        this.lexer        = lexer;
        this.tokens       = [];
        this.options      = options;
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

        return new AstFile({
            name    : path.basename(this.options.path),
            root    : this.ast.root,
            path    : path.resolve(this.options.path),
            ast     : this.ast,
        });
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

        while(![TokenKind.RightBracket, TokenKind.Eof].includes(this.currentToken.kind)) {
            const expression = this.parseExpression();

            expressions.push(expression);

            this.readToken();

            // move currentToken to next value, skip , token
            if (this.currentToken.kind === TokenKind.Comma) {
                this.readToken();
            }
        }

        if (this.currentToken.kind !== TokenKind.RightBracket) {
            this.throwUnexpectedToken("]", this.currentToken);
        }

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

    throwUnexpected(message, token) {
        throw new ParseUnexpectedException(message, token);
    }

}

function createParser(lexer, options) {
    return new Parser(lexer, options)
}

export {
    createParser
}
