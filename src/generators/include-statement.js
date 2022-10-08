import fs from 'fs';
import path from 'path';
import { createLexer } from '../lexer.js';
import { createParser } from '../parser.js';

export default function generateIncludeStatement(generator, node, env) {
    const filePath = generator.produce(node.path);
    const fullPath = path.join(env.program.root, filePath);

    if (fs.existsSync(fullPath) === false) {
        generator.throwUnexpectedException(`not found include path: ${filePath}`);
    }

    const fileContent = fs.readFileSync(fullPath);

    const lexer = createLexer(fileContent);
    const parser = createParser(lexer, {
        root: env.program.root
    });

    generator.produce(parser.parse(), env);
}
