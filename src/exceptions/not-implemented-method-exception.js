import CustomError from './custom-error.js';

export default class NotImplementedMethodException extends CustomError {

    constructor(childName, name) {
        super(
            `Not implemented method, ${childName}.${name}`
        );
    }

}
