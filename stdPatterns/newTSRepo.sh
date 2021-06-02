#!/bin/bash
#TODO: svelte creates a porject while VTS uses the current db
#TODO: refactor a bit and create a db function
function tsFolders () {

    echo "creating the folder structure"
    if [ ! -d src ] && [[ $1 != 'GQL' ]]
    then
        echo "creating the src folder (TS ONLY) no backend"
        mkdir -p src/
        touch src/server.ts
        cat >> src/server.ts << EOL
import express from "express";
import { __prod__ } from "./constants";

const app = express();
const PORT: string | number = process.env.PORT || 4000;

app.use(express.static(__dirname + "/../public/"));
app.use("*/dist",express.static(__dirname + "/../dist/"));

app.get("/", (req, res) => {
    res.sendFile("index.html");
});

app.listen(PORT, () => console.log());
EOL
    fi

    #graphqL, typeOrm w/ DB
    if [ ! -d src ] && [[ $1 == 'GQL' ]]
    then
        echo "creating the src folder (TS ONLY) no backend"
        mkdir -p src/
        touch src/server.ts
        cat >> src/server.ts << EOL
import express from "express";
import { ApolloServer } from "apollo-server-express"
import { typeDefs } from "./schema/typeDefs"
import { resolvers } from "./schema/resolvers"
import { __prod__ } from "./constants";

async function startApolloServer() {


  const server = new ApolloServer({ typeDefs, resolvers });
  await server.start();

  const app = express();
  const PORT: string | number = process.env.PORT || 4000;

  app.use(express.static(__dirname + "/../public/"));
  app.use("*/dist",express.static(__dirname + "/../dist/"));

  app.get("/", (req, res) => {
    res.sendFile("index.html");
  });


  server.applyMiddleware({ app });

  await new Promise(resolve => app.listen({ port: PORT }, resolve));
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`);
  return { server, app };
}

startApolloServer()
EOL

    mkdir -p src/schema/
    touch src/schema/resolvers.ts
    cat >> src/schema/resolvers.ts << EOL
export const resolvers = {
  Query: {
    hello: () => 'Hello world!',
  },
};
EOL

    touch src/schema/typeDefs.ts
    cat >> src/schema/typeDefs.ts << EOL
import { gql } from "apollo-server-express"
// Construct a schema, using GraphQL schema language
export const typeDefs = gql\`
  type Query {
    hello: String
}
\`;
EOL


        read -p "name of db" DBNAME
        createdb $DBNAME
        
    fi
    echo "installing apollo graphqL (api) and TypeOrm (db interface)"
    npm install apollo-server-express
    fi
    #TODO:checl the logic of the bellow block
    #tring to DRY
    if [ -f src/index.ts ]
    then
        touch src/index.ts
        cat >> src/index.ts << EOL
        console.log("Hello World, don't forget to inspect when debugging")
EOL
    else
        echo 'index.ts exist. We do not want to overwrite'
    fi
    
    if [ -f src/constants.ts]
    then
        echo 'creating constants.ts where you can store all your constants'
        car >> src/constants.ts << EOL
export const __prod__ = process.env.NODE_ENV === 'production'
EOL
    fi

    if [ ! -d public ] 
    then
    # creating and populating a very simple html page
        echo "creating the staic html pages"
        mkdir -p public/
        touch public/index.html
        cat >> public/index.html << EOL
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- dev only auto reloads the html page -->
        <script type="text/javascript" src="https://livejs.com/live.js"></script>
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
    
    if [ ! -d public/css ] 
    then
        echo "creating the stactic css folder"
    
        mkdir -p public/css/
        touch public/css/style.css
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

    if [ ! -d data ] 
    then
        mkdir -p data/
        echo 'data folders created'
    else
        echo 'data folders already present'
    fi
    
    if [ ! -f .env ]
    then
        touch .env
        echo 'Empty .env file created'
    else
        echo '.env file detected'
    fi

} 
function dbCreation() {

    if [[ $1 == 'GQL' ]]
    then

        echo "installing the required packages for db"
        npm install typeorm
        echo "creating postgres/ormconfigfile"
        touch ormconfig.json
        cat >> ormconfig.json << EOL
{
  "type": "postgres",
  "host": "localhost",
  "port": 5432,
  "database": "graphqldb",
  "synchronize": true,
  "logging": true,
  "entities": ["src/entities/**/*.ts"]
}
EOL
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
    json -I -f package.json -e "this.scripts.dev=\"nodemon dist/server.js\""
    json -I -f package.json -e "this.scripts.start=\"node dist/server.js\""

}

function gitFiles(){
    
    echo -e "\nCreating github CI/CD folders"
    # -f for file -d for directory
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

function svelteTS() {
    # https://daveceddia.com/svelte-typescript-jest/
    read -p 'Directory name for the svelte project: ' DIRECTORYNAME
    npx degit 'dceddia/svelte-typescript-jest#main' $DIRECTORYNAME
    (cd ./$DIRECTORYNAME && npm install && npm test && json -I -f package.json -e "this.scripts.start=\"sirv public -p 4000\"")
    curl https://raw.githubusercontent.com/sveltejs/template/master/.gitignore--output ./$DIRECTORYNAME/.gitignore
        cat >> ./$DIRECTORYNAME/.gitignore << EOL
# user defined
# databases
data/
EOL



}

function main() {
    echo "what TS project do you want to init?"
    read -p 'Vanila TS (VTS)/ Svelte TS (STS)' FRAMEWORK
    read -p 'backend Choice none (n)/ graphql (GQL)' BACKEND
    read -p 'Will the project be hosted on Github(y/n)?' GITANSWER
    
    if [[ $BACKEND != 'GQL' ]]
    then BACKEND=''
    fi

    case $FRAMEWORK in
        [vV][tT][sS])
            tsFolders $BACKEND
            npmInit
            dbCreation
        ;;
        [sS][tT][sS])
            svelteTS
        ;;
        *) echo 'please select VTS or STS'
    esac
    echo $DIRECTORYNAME
    if [ $GITANSWER == 'y' ]
    then
        gitFiles
        repoInit
    #else 
    #    (cd ./$DIRECTORYNAME && gitFiles && repoInit)
    fi

}

main
