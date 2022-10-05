import CustomError from './custom-error.js';

export default class ParseUnexpectedException extends CustomError {

    constructor(message, token) {
        super(
            `Parse unexpected, ${message} in (line: ${token.line}, column: ${token.column})`
        );
    }

}
