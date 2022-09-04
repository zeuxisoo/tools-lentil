import CustomError from './custom-error.js';

export default class ParseUnexpectedTokenException extends CustomError {

    constructor(want, token) {
        super(
            `Parse unexpected token, Expected next token \`${want}\`, but got token \`${token.value}\` in (line: ${token.line}, column: ${token.column})`
        );
    }

}
