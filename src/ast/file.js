class File {

    constructor(options) {
        this.name     = options.name;
        this.root     = options.root;
        this.path     = options.path;
        this.ast      = options.ast;
        this.includes = options.includes;
    }

}

export default File;
