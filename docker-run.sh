#!/bin/bash
docker run -p 3000:3000 -v ${HOME}/projects:/root/projects -it mechaid/vim-react-dev zsh
