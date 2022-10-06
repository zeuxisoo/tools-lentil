import fs from 'fs';
import path from 'path';
import { createLexer } from './lexer.js';
import { createParser } from './parser.js';
import { createGenerator } from './generator.js';

(() => {

    const options = process.argv.slice(2);

    if (options.length !== 1) {
        console.log("Please enter file path");
        return;
    }

    const filePath = options[0];

    if (fs.existsSync(filePath) === false) {
        console.log("The file path is not file");
        return;
    }

    const fileContent = fs.readFileSync(filePath);
    const fileRoot    = path.resolve(path.dirname(filePath));

    const lexer = createLexer(fileContent);
    const parser = createParser(lexer, {
        root: fileRoot,
    });
    const generator = createGenerator(parser);

    generator.generate();
})();
