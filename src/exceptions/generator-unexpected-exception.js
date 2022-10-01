import CustomError from './custom-error.js';

export default class GeneratorUnexpectedException extends CustomError {

    constructor(message) {
        super(
            `Generator unexpected produce, ${message}`
        );
    }

}
