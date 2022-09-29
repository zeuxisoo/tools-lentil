import { AssignExpression } from "../ast/index.js";

export default function generateConfigBlockStatement(generator, node, env) {
    for(const v of node.values) {
        if (v instanceof AssignExpression) {
            const name = generator.produce(v.left, env);
            const data = generator.produce(v.right, env);

            env.addConfig(name, data);
        }
    }

    return null;
}
