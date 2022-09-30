class Environment {

    constructor() {
        this.configs   = {};
        this.variables = {};
    }

    addConfig(key, value) {
        this.configs[key] = value;
    }

    addVariable(key, value) {
        this.variables[key] = value;
    }

}

export default Environment;
