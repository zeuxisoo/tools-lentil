import { isWhiteSpace, isNewline, isColon, isAlpha, isDigi, isLiteral, isIdentifier, isAccount, isCurrency, isString } from './utils/matcher.js';

class Lexer {

    constructor(content) {
        this.content         = content.toString();
        this.currentPosition = 0;
        this.nextPosition    = 0;
        this.currentChar     = '';
        this.currentLine     = 1;

        this.readChar();
    }

    lex() {
        let tokens  = [];

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
                tokens.push({
                    type : "newline",
                    value: this.currentChar,
                });

                this.readChar();

                this.skipNewline(); // remove extra newline

                continue;
            }

            // Assign/Equals
            if (this.currentChar === '=') {
                tokens.push({
                    type : "equals",
                    value: this.currentChar,
                });

                this.readChar();
                continue;
            }

            // Plus
            if (this.currentChar === '+') {
                tokens.push({
                    type : "plus",
                    value: this.currentChar,
                });

                this.readChar();
                continue;
            }

            // Minus
            if (this.currentChar === '-') {
                tokens.push({
                    type : "minus",
                    value: this.currentChar,
                });

                this.readChar();
                continue;
            }

            // Bitwise And
            if (this.currentChar === '&') {
                tokens.push({
                    type : "bitwiseAnd",
                    value: this.currentChar,
                });

                this.readChar();
                continue;
            }

            // Colon
            if (isColon(this.currentChar)) {
                tokens.push({
                    type : "colon",
                    value: this.currentChar,
                });

                this.readChar();
                continue;
            }

            // Semicolon
            if (this.currentChar === ';') {
                tokens.push({
                    type : "semicolon",
                    value: this.currentChar,
                });

                this.readChar();

                this.skipWhitespace(); // skip it if exists before find title

                // Title
                if (isString(this.currentChar)) {
                    tokens.push({
                        type : "title",
                        value: this.readTitle(),
                    });
                }

                continue;
            }

            // Alpha
            if (isAlpha(this.currentChar)) {
                const literal = this.readLiteral();

                // Currency
                if (isCurrency(literal)) {
                    tokens.push({
                        type : "currency",
                        value: literal,
                    });

                    continue;
                }

                // Account
                if (isAccount(literal)) {
                    tokens.push({
                        type : "account",
                        value: literal,
                    });

                    continue;
                }

                // Identifier (If previous not matched, mean maybe identifier)
                if (isIdentifier(literal)) {
                    tokens.push({
                        type : "identifier",
                        value: literal,
                    });

                    continue;
                }

                console.log('Unknown token type: alpha');
                break;
            }

            // Number
            if (isDigi(this.currentChar)) {
                tokens.push({
                    type : "number",
                    value: this.readNumber(),
                });

                continue;
            }

            // End of file
            if (this.currentChar == 0) {
                tokens.push({
                    type : "eof",
                    value: this.currentChar,
                });

                break;
            }

            console.log(`Unknown token type, char value "${this.currentChar}" at ${this.currentPosition} position in line ${this.currentLine}`);
            break;
        }

        console.log(tokens);
    }

    // Reader
    readChar() {
        let currentChar = '';

        if (this.nextPosition < this.content.length) {
            currentChar = this.content[this.nextPosition];

            this.currentPosition = this.nextPosition;
        }else{
            this.currentPosition = 0;
        }

        if (isNewline(currentChar)) {
            this.currentLine++;
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

    readTitle() {
        let title = [];

        while(isString(this.currentChar) && !isNewline(this.currentChar) && !isColon(this.currentChar)) {
            title.push(this.currentChar);

            this.readChar();
        }

        return title.join('');
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
