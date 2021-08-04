class Parser {

    constructor(lexer) {
        this.lexer = lexer;
    }

    parse() {
        const tokens = this.lexer.lex();
    }

}

function createParser(lexer) {
    return new Parser(lexer)
}

export {
    createParser
}
