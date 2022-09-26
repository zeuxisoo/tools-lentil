class Generator {

    constructor(parser) {
        this.parser = parser;
    }

    generate() {
        const ast = this.parser.parse();

        console.dir(ast, { depth: null });
        console.log(ast.display());
    }

}

function createGenerator(parser) {
    return new Generator(parser);
}

export {
    createGenerator
}
