export default class UnknownTokenException extends Error {

    constructor(name, value, line, column) {
        super(
            `Unknown token type, ${name} value "${value}" in (line: ${line}, column: ${column})`
        );
    }

}
