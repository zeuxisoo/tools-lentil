import { generators } from './generators/index.js';
import { GeneratorUnknownException  } from './exceptions/index.js';
import Environment from './utils/environment.js';

class Generator {

    constructor(parser) {
        this.parser = parser;
    }

    generate() {
        const ast = this.parser.parse();
        const env = new Environment();

        this.produce(ast, env);

        console.log(env);
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

}

function createGenerator(parser) {
    return new Generator(parser);
}

export {
    createGenerator
}
