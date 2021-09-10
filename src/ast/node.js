import { NotImplementedMethodException } from '../exceptions/index.js';

class Node {

    display() {
        const childName = this.constructor.name;

        throw new NotImplementedMethodException(childName, "display");
    }

}

export default Node;
