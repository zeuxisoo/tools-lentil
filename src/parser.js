import Program from './ast/program.js';

class Parser {

    constructor(lexer) {
        this.lexer = lexer;
    }

    parse() {
        const ast = new Program();
        const tokens = this.lexer.lex();

        while(tokens.length > 0) {
            const token = tokens.shift();

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
