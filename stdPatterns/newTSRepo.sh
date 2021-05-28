function tsFolders () {
    echo "creating the folder structure"
    if [ ! -d src ] 
    then
        mkdir -p src/
        touch src/index.ts
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
    npm init
    sudo npm install --save-dev ts-node nodemon @types/node
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

tsFolders
npmInit
gitFiles
