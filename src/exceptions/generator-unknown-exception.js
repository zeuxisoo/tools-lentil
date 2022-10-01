import CustomError from './custom-error.js';

export default class GeneratorUnknownException extends CustomError {

    constructor(name, value, line, column) {
        super(
            `Generator unknown ast, \`${name}\` value \`${value}\` in (line: ${line}, column: ${column})`
        );
    }

}
