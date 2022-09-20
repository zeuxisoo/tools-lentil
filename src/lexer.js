import { isWhiteSpace, isNewline, isColon, isAlpha, isDigit, isLiteral, isIdentifier, isAccount, isDate, isString } from './utils/matcher.js';
import { TokenKind, ReservedKeywords } from './token.js';
import { TokenUnknownException, TokenUnexpectedException } from './exceptions/index.js';

class Lexer {

    constructor(content) {
        this.content         = content.toString();
        this.currentPosition = 0;
        this.nextPosition    = 0;
        this.currentChar     = '';
        this.currentColumn   = 0;
        this.currentLine     = 1;

        this.tokens = [];

        this.readChar();
    }

    lex() {
        while(this.currentPosition < this.content.length) {
            // Comment
            if (this.currentChar === '/') {
                if (this.nextChar() === '/') {
                    this.skipComment();
                }

                continue;
            }

            // Whitespace
            if (isWhiteSpace(this.currentChar)) {
                // skip
                this.readChar();
                continue;
            }

            // Newline
            if (isNewline(this.currentChar)) {
                // Skip create the newline token
                // this.addToken(TokenKind.NewLine, this.currentChar);
                this.readChar();

                this.skipNewline(); // remove extra newline
                continue;
            }

            // Assign/Equals
            if (this.currentChar === '=') {
                this.addToken(TokenKind.Assign, this.currentChar);
                this.readChar();
                continue;
            }

            // Left bracket
            if (this.currentChar === '[') {
                this.addToken(TokenKind.LeftBracket, this.currentChar);
                this.readChar();
                continue;
            }

            // Right bracket
            if (this.currentChar === ']') {
                this.addToken(TokenKind.RightBracket, this.currentChar);
                this.readChar();
                continue;
            }

            // Left brace
            if (this.currentChar === '{') {
                this.addToken(TokenKind.LeftBrace, this.currentChar);
                this.readChar();
                continue;
            }

            // Right brace
            if (this.currentChar === '}') {
                this.addToken(TokenKind.RightBrace, this.currentChar);
                this.readChar();
                continue;
            }

            // Double quote for string // TODO
            if (this.currentChar === '"') {
                // this.addToken(TokenKind.DoubleQuote, this.currentChar);
                // this.readChar();

                const value = this.readString();

                this.addToken(TokenKind.String, value);
                continue;
            }

            // Comma
            if (this.currentChar === ',') {
                this.addToken(TokenKind.Comma, this.currentChar);
                this.readChar();
                continue;
            }

            // Plus
            if (this.currentChar === '+') {
                this.addToken(TokenKind.Plus, this.currentChar);
                this.readChar();
                continue;
            }

            // Minus
            if (this.currentChar === '-') {
                this.addToken(TokenKind.Minus, this.currentChar);
                this.readChar();
                continue;
            }

            // Bitwise And
            if (this.currentChar === '&') {
                this.addToken(TokenKind.BitwiseAnd, this.currentChar);
                this.readChar();
                continue;
            }

            // Colon
            if (this.currentChar === ':') {
                this.addToken(TokenKind.Colon, this.currentChar);
                this.readChar();

                if (isString(this.nextChar())) {
                    this.addToken(TokenKind.Atom, this.readAtom());
                }

                continue;
            }

            // Semicolon
            if (this.currentChar === ';') {
                this.addToken(TokenKind.Semicolon, this.currentChar);
                this.readChar();

                this.skipWhitespace(); // skip it if exists before find title

                // Title
                if (isString(this.currentChar)) {
                    this.addToken(TokenKind.Title, this.readTitleOrDescription());
                }

                // Description
                if (isColon(this.currentChar)) {
                    this.readChar(); // skip colon ";"

                    this.addToken(TokenKind.Description, this.readTitleOrDescription());
                }

                continue;
            }

            // Alpha
            if (isAlpha(this.currentChar)) {
                const literal = this.readLiteral();

                // Account
                if (isAccount(literal)) {
                    this.addToken(TokenKind.Account, literal);
                    continue;
                }

                // Identifier/Keyword (If previous not matched, mean maybe identifier or keyword)
                if (isIdentifier(literal)) {
                    const tokenType = ReservedKeywords[literal] !== undefined
                        ? ReservedKeywords[literal]
                        : TokenKind.Identifier;

                    this.addToken(tokenType, literal);
                    continue;
                }

                this.throwUnknownError('alpha', this.currentChar);
                break;
            }

            // Number
            if (isDigit(this.currentChar)) {
                const previousState = [
                    this.currentPosition, this.nextPosition,
                    this.currentChar, this.currentColumn,
                    this.currentLine
                ];

                const value = this.readDate();

                if (isDate(value)) {
                    this.addToken(TokenKind.Date, value);
                }else{
                    [
                        this.currentPosition, this.nextPosition,
                        this.currentChar, this.currentColumn,
                        this.currentLine
                    ] = previousState;

                    this.addToken(TokenKind.Number, this.readNumber());
                }

                continue;
            }

            // End of file
            if (this.currentChar == 0) {
                this.addToken(TokenKind.Eof, this.currentChar);
                break;
            }

            this.throwUnknownError('char', this.currentChar);
            break;
        }

        return this.tokens;
    }

    addToken(kind, value) {
        this.tokens.push({
            kind,
            value,
            line  : this.currentLine,
            column: this.currentColumn,
        });
    }

    throwUnknownError(name, value) {
        throw new TokenUnknownException(name, value, this.currentLine, this.currentColumn);
    }

    throwUnexpectedError(want, value) {
        throw new TokenUnexpectedException(want, value, this.currentLine, this.currentColumn);
    }

    // Reader
    readChar() {
        let currentChar = '';

        if (this.nextPosition < this.content.length) {
            currentChar = this.content[this.nextPosition];

            this.currentPosition = this.nextPosition;
            this.currentColumn++;
        }else{
            this.currentPosition = 0;
        }

        if (isNewline(currentChar)) {
            this.currentLine++;
            this.currentColumn = 0;
        }

        this.currentChar = currentChar;

        this.nextPosition++;
    }

    readLiteral() {
        let literal = [];

        while(isLiteral(this.currentChar)) {
            literal.push(this.currentChar);

            this.readChar();
        }

        return literal.join('');
    }

    readString() {
        let strings = [];

        this.readChar(); // skip start "

        while(this.currentChar !== '"') {
            // skip the escaped char
            if (this.currentChar === "\\") {
                this.readChar();
            }

            // when meet empty/eof meet double quote not exists
            if (this.currentChar == 0) {
                this.throwUnexpectedError('"', this.currentChar);
            }

            strings.push(this.currentChar);

            this.readChar();
        }

        this.readChar(); // skip end "

        return strings.join('');
    }

    readDate() {
        let value = [];

        while(isDigit(this.currentChar) || this.currentChar === "-") {
            value.push(this.currentChar);

            this.readChar();
        }

        return value.join('');
    }

    readAtom() {
        let value = [];

        while(isString(this.currentChar) && !isNewline(this.currentChar) && !isWhiteSpace(this.currentChar)) {
            value.push(this.currentChar);

            this.readChar();
        }

        return value.join('');
    }

    readTitleOrDescription() {
        let text = [];

        while(isString(this.currentChar) && !isNewline(this.currentChar) && !isColon(this.currentChar)) {
            text.push(this.currentChar);

            this.readChar();
        }

        return text.join('');
    }

    readNumber() {
        let number = [];

        while(isDigit(this.currentChar)) {
            number.push(this.currentChar);

            this.readChar();
        }

        return number.join('');
    }

    // Helper
    previousChar() {
        const previousPosition = this.currentPosition - 1;

        if (previousPosition <= 0) {
            return '';
        }

        return this.content[previousPosition];
    }

    nextChar() {
        if (this.nextPosition > this.content.length) {
            return 0;
        }

        return this.content[this.nextPosition];
    }

    // Skipper
    skipComment() {
        while(!isNewline(this.currentChar)) {
            this.readChar();
        }

        this.skipNewline(); // remove extra newline
    }

    skipWhitespace() {
        while(isWhiteSpace(this.currentChar)) {
            this.readChar();
        }
    }

    skipNewline() {
        // E.g. (e.g. \n + "empty newline" + code)
        while(isNewline(this.currentChar)) {
            this.readChar();
        }
    }
}

function createLexer(content) {
    return new Lexer(content);
}

export {
    createLexer
}
