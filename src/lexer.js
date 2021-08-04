import { isWhiteSpace, isNewline, isColon, isComma, isAlpha, isIdentifier, isAccount, isCJK } from './utils.js';

class Lexer {

    constructor(content) {
        this.content         = content.toString();
        this.currentPosition = 0;
        this.nextPosition    = 0;
        this.currentChar     = '';

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

            // Semicolon
            if (this.currentChar === ';') {
                tokens.push({
                    type : "semicolon",
                    value: this.currentChar,
                });

                this.readChar();

                this.skipWhitespace(); // skip it if exists before find title

                // Title
                if (isCJK(this.currentChar)) {
                    tokens.push({
                        type : "description",
                        value: this.readDescription(),
                    });
                }

                continue;
            }

            // Alpha
            if (isAlpha(this.currentChar)) {
                // Identifier
                if (isIdentifier(this.currentChar)) {
                    tokens.push({
                        type : "identifier",
                        value: this.readIdentifier(),
                    });

                    continue;
                }

                // Account
                if (isAccount(this.currentChar))  {
                    tokens.push({
                        type : "account",
                        value: this.readAccount(),
                    });

                    continue;
                }

                console.log('Unknown token type: alpha');
                break;
            }

            // End of file
            if (this.currentChar == 0) {
                tokens.push({
                    type : "eof",
                    value: this.currentChar,
                });

                break;
            }

            console.log(`Unknown token type: "${this.currentChar}", ${this.currentPosition}`);
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

        this.currentChar = currentChar;

        this.nextPosition++;
    }

    readIdentifier() {
        let identifier = [];

        while(isIdentifier(this.currentChar)) {
            identifier.push(this.currentChar);

            this.readChar();
        }

        return identifier.join('');
    }

    readAccount() {
        let account = [];

        while(isAccount(this.currentChar) || isAlpha(this.currentChar) || isColon(this.currentChar)) {
            account.push(this.currentChar);

            this.readChar();
        }

        return account.join('');
    }

    readDescription() {
        let description = [];

        while(isCJK(this.currentChar) || isAlpha(this.currentChar)) {
            description.push(this.currentChar);

            this.readChar();
        }

        return description.join('');
    }

    // Helper
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
