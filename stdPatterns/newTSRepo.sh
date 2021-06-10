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
        npm install ts-node type/graphqL
        echo "creating the src folder (TS ONLY) w/ graphql"
        mkdir -p src/
        touch src/server.ts
        cat >> src/server.ts << EOL
import 'reflect-metadata'
import express from 'express'
import { ApolloServer } from 'apollo-server-express'
import { buildSchema } from 'type-graphql';

//import { typeDefs } from './schema/typeDefs'
import { resolvers } from './schema/resolvers'
import { init_db } from './database'
import { __prod__,__port__ } from './constants'

async function startApolloServer () {
  await init_db().catch((error) => console.log(error))
  console.log('Database created.');
  //check schema and how t add typeDefs
  const schema = await buildSchema({
    resolvers: [ resolvers ],
  });
  const server = new ApolloServer({ schema })
  await server.start()

  const app = express()

  app.use(express.static(__dirname + '/../public/'))
  app.use('*/dist', express.static(__dirname + '/../dist/'))

  app.get('/', (req, res) => {
    res.sendFile('index.html')
  })

  server.applyMiddleware({ app })

  await new Promise((resolve) => app.listen({ port: __port__ }, resolve))
  return { server, app }
}

startApolloServer()
EOL

    echo 'adjusting the package.json for VTS'

    json -I -f package.json -e "this.scripts.start=\"ts-node --transpile-only src/server.ts\""
    json -I -f package.json -e "this.scripts.lint:watch=\"watch 'npm run lint' .\""
    json -I -f package.json -e "this.scripts.dev=\"nodemon --watch 'src/**' --ext 'ts,json' --ignore 'src/**/*.spec.ts' --exec 'ts-node --transpile-only src/server.ts'\""

        
    fi

    #tring to DRY
    if [ -f src/index.ts ]
    then
        echo 'index.ts exist. We do not want to overwrite'
    else
        touch src/index.ts
        cat >> src/index.ts << EOL
        console.log("Hello World, don't forget to inspect when debugging")
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

    echo "installing the required packages for db"
    npm install typeorm pg
    echo "installing apollo graphqL (api) and TypeOrm (db interface)"
    npm install apollo-server-express type-graphql
    echo "creating postgres/ormconfigfile linking to default db"
    touch ormconfig.json
    cat >> ormconfig.json << EOL
{
  "type": "postgres",
  "host": "localhost",
  "port": 5432,
  "username": "postgres",
  "password": "",
  "database": "graphqldb",
  "synchronize": true,
  "logging": true,
  "entities": ["src/entity/**/*.ts"],
  "migrations": ["src/migration/**/*.ts"],
  "subscribers": ["src/subscriber/**/*.ts"],
  "cli": {
    "entitiesDir": "src/entity",
    "migrationsDir": "src/migration",
    "subscribersDir": "src/subscriber"
  }
}
EOL
    
    echo 'creating the migration folder'
    mkdir -p src/migration
    mkdir -p src/entity
    touch src/entity/user.ts
    cat >> src/entity/user.ts <<EOL
import { Entity, PrimaryGeneratedColumn, Column, BaseEntity } from 'typeorm'
import { ObjectType, Field, ID } from 'type-graphql'

@Entity('users')// typeorm
@ObjectType()// graphql
export class User extends BaseEntity {
    @Field(() => ID)// graphql
    @PrimaryGeneratedColumn()// typeorm
    id: number;

    @Field(() => String)
    @Column()
    firstName: string;

    @Field(() => String)
    @Column()
    lastName: string;

    @Field(() => Number)
    @Column()
    age: number;
}
EOL
    touch src/database.ts
    cat >> src/database.ts << EOL
import { createConnection } from 'typeorm';
import { User } from './entity/user';
import { __prod__ } from './constants'

export const init_db = async() => {
  const connection = await createConnection();
  if (!__prod__) {
    await connection.dropDatabase();
  }
  await connection.synchronize();

  // User
  const user = new User();
  user.firstName = 'Timsd1231ber'
  user.lastName = 'chasdaad@chad'
  user.age = 56
  await user.save()

  };
EOL
    mkdir -p src/schema/
    touch src/schema/resolvers.ts
    echo "creating TypeOrm and graphql resolvers w/ CRUD"

    cat >> src/schema/resolvers.ts << EOL
import { Resolver, Query, Mutation, Arg } from "type-graphql";
import { User } from '../entity/user'

@Resolver()
export class resolvers  {
  @Query(() => String)
  hello() {
    return "world";
  }
  //findall
  @Query(() => [ User ])
  async getAllUsers() {
    return await User.find()
  }
  //findone
  @Query(() => User)
  user(@Arg("id") id: number) {
    return User.findOne({ where: { id }});
  }
  //CREATE
  @Mutation(() => User )
  async createNewUser(
    @Arg('firstName') firstName:string,
    @Arg('lastName') lastName:string,
    @Arg('age') age:number): Promise<User> {
    const newUser = User.create({firstName, lastName, age})
    await newUser.save()
    return newUser
  }
  //UPDATE
  @Mutation(() => User)
  async updateUser(
    @Arg("id") id: number,
    @Arg('firstName', { nullable: true }) firstName:string,
    @Arg('lastName', { nullable: true }) lastName:string,
    @Arg('age', { nullable: true }) age:number): Promise<User> {
    const user = await User.findOne({ where: { id }});

    if (!user) {
      throw new Error(`The user with id: ${id} does not exist!`);
    }

    Object.assign(user, {firstName, lastName, age});
    await user.save();

    return user;
  }
  //DELETE
  @Mutation(() => Boolean)
  async deleteUser(
    @Arg("id") id: number,
  ):Promise<Boolean> {
  const user = await User.findOne({ where: { id }});

  if (!user) {
    throw new Error(`The user with id: ${id} does not exist!`);
  }
  await user.remove();
  return true;

  }
};

EOL
    #TODO: FIND a GENERATOR
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
    if [[ $DBNAME == '' ]]
    then
        echo 'skipping db creation'
    else
        createdb $DBNAME
    fi
 
}

function npmInit() {

    npm init -y # accepting everything to the default
    # I am honestly very confused by node so we will be using its simpler brother (express)
    #sudo npm install --save-dev ts-node nodemon @types/node
    sudo npm install --save-dev eslint nodemon watch
    sudo npm install typescript express @types/express
    npx tsconfig.json
    echo 'updating the package.json'
    json -I -f package.json -e "this.scripts.watch=\"tsc -w\""
    json -I -f package.json -e "this.scripts.dev=\"nodemon dist/server.js\""
    json -I -f package.json -e "this.scripts.start=\"node dist/server.js\""
    ./node_modules/.bin/eslint --init
    json -I -f package.json -e "this.scripts.lint=\"eslint ./src/**/*.ts\""
    json -I -f package.json -e  "this.scripts.lint:watch=\"watch 'npm run lint' .\""

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
    if [[ $1 != 'GQL' ]]
    then
        read -p 'Directory name for the svelte project: ' DIRECTORYNAME
        npx degit 'dceddia/svelte-typescript-jest#main' $DIRECTORYNAME
        (cd ./$DIRECTORYNAME && npm install && npm test && json -I -f package.json -e "this.scripts.start=\"sirv public -p 4000\"")
        curl https://raw.githubusercontent.com/sveltejs/template/master/.gitignore--output ./$DIRECTORYNAME/.gitignore
        cat >> ./$DIRECTORYNAME/.gitignore << EOL
# user defined
# databases
data/
EOL
    else
        echo ''
        # there's lots of goof things in svelte@next like eslint prettier
        npm init svelte@next
        #npm init @vitejs/app .
        echo 'installing tailwind and jest(TDD)'
        npx svelte-add tailwindcss
        npm install --save-dev jest babel-jest @babel/core @babel/preset-env @babel/preset-typescript
        touch babel.config.js
        cat >> babel.config.js <<EOL
module.exports = {
  presets: [
    ['@babel/preset-env', {targets: {node: 'current'}}],
    '@babel/preset-typescript',
  ],
};
EOL
        npm install
        #TODO: add jest and create a simple hello world test package
        echo 'adjusting the package.json for STS'
        json -I -f package.json -e "this.scripts.dev=\"svelte-kit dev --port 4000\""
        json -I -f package.json -e "this.scripts.test=\"jest\""
        #WARN: The svelte tsconfig generates error blocking the following 6 lines of code

        json -I -f tsconfig.json -e "this.compilerOptions.experimentalDecorators=true"
        json -I -f tsconfig.json -e "this.compilerOptions.emitDecoratorMetadata=true"
        json -I -f tsconfig.json -e "this.compilerOptions.strictNullChecks=true"
        json -I -f tsconfig.json -e "this.compilerOptions.strictFunctionTypes=true"
        json -I -f tsconfig.json -e "this.compilerOptions.removeComments=true"
        json -I -f tsconfig.json -e "this.compilerOptions.noUnusedLocals=true"
        
        dbCreation
    fi


}


function vueTS () {
    # sends it to another folder
    npm init @vitejs/app . -- --template vue-ts --yes
    npm install tailwindcss
    npm install --save-dev eslint watch

    json -I -f .eslintrc.json -e "this.scripts.lint=\"eslint ./src/**/*.{ts,vue}\"",
    json -I -f .eslintrc.json -e "this.scripts.lint:fix=\"eslint ./src/**/*.{ts,vue} --fix\""
    json -I -f .eslintrc.json  -e "this.scripts.lint:watch=\"watch 'npm run lint' .\""

    json -I -f tsconfig.json -e "this.compilerOptions.experimentalDecorators=true"
    json -I -f tsconfig.json -e "this.compilerOptions.emitDecoratorMetadata=true"
    json -I -f tsconfig.json -e "this.compilerOptions.strictNullChecks=true"
    json -I -f tsconfig.json -e "this.compilerOptions.strictFunctionTypes=true"
    json -I -f tsconfig.json -e "this.compilerOptions.removeComments=true"
    json -I -f tsconfig.json -e "this.compilerOptions.noUnusedLocals=true"



    touch src/index.css
    cat >> src/index.css << EOL
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL


    touch tailwind.config.js
    cat >> tailwind.config.js <<EOL
module.exports = {
  purge: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOL


    touch postcss.config.js
    cat >> postcss.config.js << EOL
module.exports = {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
}
EOL

}
touch .eslintrc.json
cat >> .eslintrc.json << EOL
{
    "env": {
        "browser": true,
        "es2021": true,
        "node": true
    },
    "extends": [
        "eslint:recommended",
        "plugin:vue/essential",
        "plugin:@typescript-eslint/recommended"
    ],
    "parserOptions": {
        "ecmaVersion": 12,
        "parser": "@typescript-eslint/parser",
        "sourceType": "module"
    },
    "plugins": [
        "vue",
        "@typescript-eslint"
    ],
    "rules": {
        "indent": [
            "error",
            "tab"
        ],
        "linebreak-style": [
            "error",
            "unix"
        ],
        "quotes": [
            "error",
            "single"
        ],
        "semi": [
            "error",
            "always"
        ]
    }
}
EOL

function main() {
    echo "what TS project do you want to init?"
    read -p 'Vanila TS (VTS)/ Svelte TS (STS)/ Vue TS w/Vite (VTS)' FRAMEWORK
    read -p 'Api choice none (n)/ graphql (GQL)' BACKEND
    read -p 'Do you need a Postgres DB (y/n)' DBBACKEND
    read -p 'Will the project be hosted on Github(y/n)?' GITANSWER
    
    if [[ $BACKEND != 'GQL' ]]
    then BACKEND=''
    fi

    case $FRAMEWORK in
        [vV][tT][sS])
            tsFolders $BACKEND
            npmInit
            if [[ $DBBACKEND == 'y' ]]
            then
                dbCreation
            fi
        ;;
        [sS][tT][sS])
            svelteTS $BACKEND
        ;;
        *) echo 'please select VTS or STS'
        [vV][tT][sS]
            vueTS $BACKEND
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

#TODO: refactor. svelte needs it.
if [ -f src/constants.ts ]
then
    echo "constants.ts already exists"
else
    echo 'creating constants.ts where you can store all your constants'
    cat >> src/constants.ts << EOL
export const __prod__ = process.env.NODE_ENV === 'production'
export const __port__ = process.env.NODE_ENV === 4000
EOL
fi

