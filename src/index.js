import fs from 'fs';

(() => {

    const options = process.argv.slice(2);

    if (options.length !== 1) {
        console.log("Please enter file path");
        return;
    }

    const filePath = options[0];

    if (fs.statSync(filePath).isFile() === false) {
        console.log("The file path is not file");
        return;
    }

    const fileContent = fs.readFileSync(filePath);

    console.log(fileContent.toString());
})();
