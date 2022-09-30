import { AssignExpression } from "../ast/index.js";

export default function generateAssignExpression(generator, node, env) {
    const name = generator.produce(node.left, env);
    const data = generator.produce(node.right, env);

    env.addVariable(name, data);

    return null;
}
