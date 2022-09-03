import CustomError from './custom-error.js';

export default class TokenUnknownException extends CustomError {

    constructor(name, value, line, column) {
        super(
            `Token unexpected type, \`${name}\` value \`${value}\` in (line: ${line}, column: ${column})`
        );
    }

}
