class Environment {

    constructor() {
        this.configs = {};
    }

    addConfig(key, value) {
        this.configs[key] = value;
    }

}

export default Environment;
