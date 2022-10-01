import CustomError from './custom-error.js';

export default class GeneratorCurrencyNotFoundException extends CustomError {

    constructor(name) {
        super(
            `Generator currency not found, identifier: \`${name}\``
        );
    }

}
