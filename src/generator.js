import {
    Program,
    ConfigStatement, ConfigBlockStatement,
    IdentifierExpression, ArrayExpression, StringExpression,
} from './ast/index.js';
import {
    generateProgram,
    generateConfigStatement, generateConfigBlockStatement,
    generateIdentifierExpression
} from './generators/index.js';
import Environment from './utils/environment.js';
import { GeneratorUnknownException  } from './exceptions/index.js';

class Generator {

    constructor(parser) {
        this.parser = parser;
    }

    generate() {
        const ast = this.parser.parse();
        const env = new Environment();

        this.produce(ast, env);

        console.log(env.configs);
    }

    produce(node, env) {
        switch(node.constructor) {
            case Program:
                return generateProgram(this, node, env);
            case ConfigStatement:
                return generateConfigStatement(this, node, env);
            case ConfigBlockStatement:
                return generateConfigBlockStatement(this, node, env);
            case IdentifierExpression:
                return generateIdentifierExpression(this, node, env);
            case ArrayExpression:
                let items = [];

                for(const v of node.values) {
                    items.push(this.produce(v, env));
                }

                return items;
            case StringExpression:
                return node.value;
            default:
                throw new GeneratorUnknownException(
                    node.constructor.name,
                    node.token.value,
                    node.token.line,
                    node.token.column,
                )
        }
    }

}

function createGenerator(parser) {
    return new Generator(parser);
}

export {
    createGenerator
}