function tsFolders () {
    echo "creating the folder structure"
    if [ ! -d src ] 
    then
        echo "creating the src folder"
        mkdir -p src/
        touch src/index.ts
        cat >> src/index.ts << EOL
EOimport express from "express";

const app = express();
const port = 4000;
app.use(express.static(__dirname + "/../assets/"));

app.get("/", (req, res) => {
    res.sendFile("index.html");
});

app.listen(port, (err) => {
    if (err) {
        return console.error(err);
    }
    return console.log();
});
EOL
    fi

    if [ ! -d css ] 
    then
        echo "creating the stactic css folder"
    
        mkdir -p css/
        touch css/style.css
    fi

    if [ ! -d assets ] 
    then
    # creating and populating a very simple html page
        echo "creating the staic html pages"
        mkdir -p assets/
        touch assets/index.html
        cat >> src/index.html << EOL
<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <h1> Hello World</h1> 
        <script src="src/index.js"></script>
    </body>
</html>    
EOL
    fi

    touch tslint.json
    cat >> tslint.json << EOL
{
  "defaultSeverity": "error",
  "extends": ["tslint:recommended"],
  "jsRules": {},
  "rules": {
    "no-console": false
  },
  "rulesDirectory": []
}
EOL
    fi

    if [ ! -d data ] 
    then
        mkdir -p data/
        echo 'data folders created'

    fi
    
    if [ ! -f .env ]
    then
        touch .env
        echo 'Empty .env file created'
    fi

} 

function npmInit() {
    npm init -y # accepting everything to the default
    # I am honestly very confused by node so we will be using its simpler brother (express)
    #sudo npm install --save-dev ts-node nodemon @types/node
    sudo npm install --save-dev typescript tslint nodemon express @types/express
    npx tsconfig.json
    echo 'updating the package.json'
    json -I -f package.json -e "this.scripts.watch=\"tsc -w\""
    json -I -f package.json -e "this.scripts.dev=\"nodemon dist/index.js\""
    json -I -f package.json -e "this.scripts.start=\"node dist/index.js\""

}

function gitFiles(){
    echo -e "\nCreating github CI/CD folders"
    # -f for file -d for directoy
    if [ ! -d .github ]
    then
        # -p for parents
        mkdir actions-a
        mkdir -p .github/workflows
        echo 'Created the workflows and actions-a folders'
    fi

    if [ ! -f README.md ]
    then
        touch README.md
        echo 'README.md file created'
    fi
    if [ ! -f .gitignore ]
    then
        touch .gitignore
        echo '.gitignore file created'
        # the alternative is to use an EOL and define what
        curl https://raw.githubusercontent.com/microsoft/TypeScript-Node-Starter/master/.gitignore --output .gitignore # recommend raw for github otherwise there's html formatting
        cat >> .gitignore << EOL
# user defined
newTSRepo.sh
# databases
data/
EOL
    fi

}
# not activated (need to add more logic)
function repoInit(){

    if [ ! -d .git ]
    then
        git init
        git add *
        git commit -a -m 'first commit'
        git branch -M main 
        read -p 'What is the SSH(prefered)/HTTPS GitHub address?': ADDRESS
        git remote add origin $ADDRESS
        git config --global user.name "Henri Vandersleyen"
        git config --global user.email hvandersleyen@gmail.com
        echo 'pushing first commit to main'
        git push -u origin main
        git pull
    else
        echo 'repo is already present'
    fi
}


tsFolders
npmInit
gitFiles
#repoInit
