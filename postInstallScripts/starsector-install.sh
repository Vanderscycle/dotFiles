#!/bin/bash

GAME_VERSION="0.96a-RC10"
mkdir -p ~/Games/fractal-softworks

# httpie
http --download https://s3.amazonaws.com/fractalsoftworks/starsector/starsector_linux-$GAME_VERSION.zip
unzip -q ./starsector_linux-$GAME_VERSION.zip -d ~/Games/fractal-softworks
rm ./starsector_linux-$GAME_VERSION.zip
