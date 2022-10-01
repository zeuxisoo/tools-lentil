import CustomError from './custom-error.js';

export default class GeneratorAccountNotFoundException extends CustomError {

    constructor(name) {
        super(
            `Generator account not found, variable: \`${name}\``
        );
    }

}
