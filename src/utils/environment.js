class Environment {

    constructor() {
        this.program   = {};
        this.configs   = {};
        this.variables = {};
    }

    addProgram(key, value) {
        this.program[key] = value;
    }

    addConfig(key, value) {
        this.configs[key] = value;
    }

    addVariable(key, value) {
        this.variables[key] = value;
    }

}

export default Environment;
