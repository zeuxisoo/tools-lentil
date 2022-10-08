import { generators } from './generators/index.js';
import {
    GeneratorUnknownException,
    GeneratorUnexpectedException,
    GeneratorAccountNotFoundException,
    GeneratorCurrencyNotFoundException,
} from './exceptions/index.js';
import Environment from './utils/environment.js';

class Generator {

    constructor(parser) {
        this.parser = parser;
    }

    generate() {
        const astFile     = this.parser.parse();
        const environment = new Environment();

        environment.addProgram('root', astFile.root);

        const result = this.produce(astFile.ast, environment);

        console.log(environment);
        console.log('----', 'result', '----');
        console.log(result.join('\n'));
    }

    produce(node, env) {
        const generator = generators[node.constructor];

        const result = generator !== undefined
            ? generator(this, node, env)
            : this.throwUnknownException(node);

        return result;
    }

    throwUnknownException(node) {
        throw new GeneratorUnknownException(
            node.constructor.name,
            node.token.value,
            node.token.line,
            node.token.column,
        );
    }

    throwUnexpectedException(message) {
        throw new GeneratorUnexpectedException(message);
    }

    throwAccountNotFoundException(name) {
        throw new GeneratorAccountNotFoundException(name);
    }

    throwCurrencyNotFoundException(name) {
        throw new GeneratorCurrencyNotFoundException(name);
    }

}

function createGenerator(parser) {
    return new Generator(parser);
}

export {
    createGenerator
}
