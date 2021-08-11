import { isWhiteSpace, isNewline, isColon, isAlpha, isDigi, isLiteral, isIdentifier, isAccount, isCurrency, isString } from './utils/matcher.js';
import { TokenKind } from './token.js';

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
                this.addToken(TokenKind.NewLine, this.currentChar);
                this.readChar();

                this.skipNewline(); // remove extra newline
                continue;
            }

            // Assign/Equals
            if (this.currentChar === '=') {
                this.addToken(TokenKind.Equals, this.currentChar);
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

                // Currency
                if (isCurrency(literal)) {
                    this.addToken(TokenKind.Currency, literal);
                    continue;
                }

                // Account
                if (isAccount(literal)) {
                    this.addToken(TokenKind.Account, literal);
                    continue;
                }

                // Identifier (If previous not matched, mean maybe identifier)
                if (isIdentifier(literal)) {
                    this.addToken(TokenKind.Identifier, literal);
                    continue;
                }

                this.unknownToken(`Unknown token type, alpha value "${this.literal}" in (line: ${this.currentLine}, column: ${this.currentColumn})`);
                break;
            }

            // Number
            if (isDigi(this.currentChar)) {
                this.addToken(TokenKind.Number, this.readNumber());
                continue;
            }

            // End of file
            if (this.currentChar == 0) {
                this.addToken(TokenKind.Eof, this.currentChar);
                break;
            }

            this.unknownToken(`Unknown token type, char value "${this.currentChar}" in (line: ${this.currentLine}, column: ${this.currentColumn})`);
            break;
        }

        console.log(this.tokens);
    }

    addToken(kind, value) {
        this.tokens.push({
            kind,
            value
        });
    }

    unknownToken(message) {
        throw new Error(message);
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

        while(isDigi(this.currentChar)) {
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
