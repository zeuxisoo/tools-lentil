import {
    Program,
    ConfigStatement, ConfigBlockStatement,
    IdentifierExpression, AssignExpression, ArrayExpression, StringExpression
} from './ast/index.js';
import { TokenKind } from './token.js';
import { ParseUnexpectedTokenException } from './exceptions/index.js';

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
        // console.log(this.tokens);
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

    parseStatement() {
        let statement = null;

        switch(this.currentToken.kind) {
            case TokenKind.Config:
                statement = this.parseConfigStatement();
                break;
            default:
                statement = this.parseExpressionStatement();
                break;
        }

        return statement;
    }

    parseConfigStatement() {
        const nextToken = this.lookNextToken();

        if (nextToken.kind !== TokenKind.LeftBrace) {
            this.throwUnexpectedToken("{", nextToken);
        }

        this.readToken(); // move currentToken to {
        this.readToken(); // move currentToken to next token

        const statement = new ConfigStatement();
        statement.block = this.parseConfigBlockStatement();

        return statement;
    }

    parseConfigBlockStatement() {
        const statement = new ConfigBlockStatement();

        while(this.currentToken.kind !== TokenKind.RightBrace && this.currentToken.kind !== TokenKind.Eof) {
            statement.values.push(this.parseStatement());

            this.readToken();
        }

        return statement;
    }

    parseExpressionStatement() {
        let statement = null;

        switch(this.currentToken.kind) {
            case TokenKind.Identifier:
                statement = this.parseIdentifierExpression();
                break;
            default:
                console.log('expressionStatement: ', this.currentToken);
                break;
        }

        return statement;
    }

    parseIdentifierExpression() {
        const nextToken = this.lookNextToken();

        if (nextToken.kind !== TokenKind.Assign) {
            this.throwUnexpectedToken("=", nextToken);
        }

        const identifierExpression = new IdentifierExpression();
        identifierExpression.token = this.currentToken;
        identifierExpression.value = this.currentToken.value;

        this.readToken(); // move currentToken to =
        this.readToken(); // move currentToken to right hand side

        const assignExpression = new AssignExpression();
        assignExpression.token = nextToken;
        assignExpression.left  = identifierExpression;
        assignExpression.right = this.parseExpression();

        return assignExpression;
    }

    parseExpression() {
        let expression = null;

        switch(this.currentToken.kind) {
            case TokenKind.LeftBracket:
                expression = this.parseArrayExpression();
                break;
            case TokenKind.String:
                expression = this.parseStringExpression();
                break;
            default:
                console.log('expression: ', this.currentToken);
                break;
        }

        return expression;
    }

    parseStringExpression() {
        const expression = new StringExpression();
        expression.token = this.currentToken;
        expression.value = this.currentToken.value;

        return expression;
    }

    parseArrayExpression() {
        const expression  = new ArrayExpression();
        expression.token  = this.currentToken;
        expression.values = this.parseExpressionList();

        return expression;
    }

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
            this.throwUnexpectedToken("]", this.lookNextToken());
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
