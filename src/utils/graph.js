class Graph {

    color = {
        white: 'unreached',
        gray : 'reached',
        black: 'finished',
    }

    constructor() {
        this.nodes = {};
    }

    addEdge(from, to) {
        if (this.nodes[from]) {
            this.nodes[from].push(to);
        }else{
            this.nodes[from] = [to];
        }
    }

    isCycle() {
        const vertices = [];

        for(let key of Object.keys(this.nodes)) {
            vertices[key] = this.color.white;
        }

        for(let key of Object.keys(this.nodes)) {
            if (vertices[key] === this.color.white) {
                if (this.depthFirstSearch(key, vertices) === true) {
                    return true;
                }
            }
        }

        return false;
    }

    depthFirstSearch(key, vertices) {
        vertices[key] = this.color.gray;

        for(let index of this.nodes[key]) {
            if (vertices[index] === this.color.gray) {
                return true;
            }

            if (
                vertices[index] === this.color.white &&
                this.depthFirstSearch(index, vertices) === true
            ) {
                return true;
            }
        }

        vertices[key] = this.color.black;

        return false;
    }

}

export default Graph;
