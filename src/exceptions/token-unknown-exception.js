import CustomError from './custom-error.js';

export default class TokenUnknownException extends CustomError {

    constructor(name, value, line, column) {
        super(
            `Unknown token type, \`${name}\` value \`${value}\` in (line: ${line}, column: ${column})`
        );
    }

}
