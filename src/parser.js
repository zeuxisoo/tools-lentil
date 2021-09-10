import Program from './ast/program.js';

class Parser {

    constructor(lexer) {
        this.lexer = lexer;
    }

    parse() {
        const ast = new Program();
        const tokens = this.lexer.lex();

        for(let i=0; i<tokens.length; i++) {
            const token = tokens[i];

            console.log(token);
        }

        console.log(ast)
        console.log(ast.display());
    }

}

function createParser(lexer) {
    return new Parser(lexer)
}

export {
    createParser
}
