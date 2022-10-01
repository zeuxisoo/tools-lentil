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
        const ast = this.parser.parse();
        const env = new Environment();

        const result = this.produce(ast, env);

        console.log(env);
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
