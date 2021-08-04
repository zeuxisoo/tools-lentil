import { isWhiteSpace, isNewline, isColon, isComma, isAlpha, isIdentifier, isAccount, isCJK } from './utils.js';

class Lexer {

    constructor(content) {
        this.content         = content.toString();
        this.currentPosition = 0;
        this.currentChar     = '';

        this.readChar();
    }

    lex() {
        let tokens  = [];

        while(this.currentPosition < this.content.length) {
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

            console.log('Unknown token type: global');
            break;
        }

        console.log(tokens);
    }

    readChar() {
        let currentChar = '';

        if (this.currentPosition < this.content.length) {
            currentChar = this.content[this.currentPosition];

            this.currentPosition++;
        }else{
            this.currentPosition = 0;
        }

        this.currentChar = currentChar;
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

    //
    skipWhitespace() {
        while(isWhiteSpace(this.currentChar)) {
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
