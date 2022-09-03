import CustomError from './custom-error.js';

export default class TokenUnexpectedException extends CustomError {

    constructor(want, value, line, column) {
        super(
            `Token unexpected type, want value \`${want}\`, but got value \`${value}\`, in (line: ${line}, column: ${column})`
        );
    }

}
