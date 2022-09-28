import {
    Program,
    ConfigStatement, ConfigBlockStatement,
    AssignExpression, IdentifierExpression, ArrayExpression, StringExpression,
} from './ast/index.js';
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
    }

    produce(node, env) {
        switch(node.constructor) {
            case Program:
                let codes = [];

                for(const statement of node.statements) {
                    codes.push(
                        this.produce(statement, env)
                    );
                }

                return codes;
            case ConfigStatement:
                this.produce(node.block, env);
                break;
            case ConfigBlockStatement:
                for(const v of node.values) {
                    if (v instanceof AssignExpression) {
                        const name = this.produce(v.left, env);
                        const data = this.produce(v.right, env);

                        env.addConfig(name, data);
                    }
                }
                break;
            case IdentifierExpression:
                return node.value;
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
