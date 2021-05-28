#!/bin/bash
# https://dzone.com/articles/data-science-project-folder-structure
# https://towardsdatascience.com/manage-your-data-science-project-structure-in-early-stage-95f91d4d0600 

# Goal, to take newRepo and enhance it more by creating the file structure for a ML project (tomorrow robot challenge)

function MLFolders(){
    echo -e "\nCreating project folder structure"
    if [ ! -d src ] 
    then 
        # Code related to feature engineering and data processing
        mkdir src
        touch src/__init__.py
        echo 'Created src folder' 
    fi

    if [ ! -d tests ] 
    then 
        # Unit tests
        mkdir tests
        touch tests/__init__.py
        echo 'Created test folder' 
    fi

    if [ ! -d models ] 
    then 
        # Trained models 
        mkdir models
        touch models/__init__.py
        echo 'Created models folder' 
    fi

    if [ ! -d data ] 
    then 
        # where the raw data lives
        mkdir data
        mkdir -p data/raw
        mkdir -p data/processed
        echo 'Created data folder' 
    fi

    if [ ! -d pipeline ] 
    then 
        # automation scripts for training/retraining a new model
        mkdir pipeline
        touch pipeline/__init__.py
        echo 'Created pipeline folder' 
    fi

    if [ ! -d docs ] 
    then 
        # all the documentation meant to inform newcomers about the ML project
        mkdir docs
        mkdir -p docs/images
        echo 'Created pipeline folder' 
    fi

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
        curl https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore --output .gitignore # recommend raw for github otherwise there's html formatting
        cat >> .gitignore << EOL
# user defined
newMLRepo.sh
# databases
data/
EOL
    fi

    if [ ! -f .env ]
    then
        touch .env
        echo 'Empty .env file created'
    fi
}

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

MLFolders
gitFiles
repoInit
