#!/bin/bash
PR_VERSION=v1.0.33-dev

FE_SOURCE_GIT="https://github.com/bokobox/animap-web.git"
FE_BRANCH="develop"
FE_PROJECT_NAME="animap-web"
FE_BUILD_FOLDER="animap-web\build"
FE_BUILD_COMMAND="npm run build:dev"

BE_SOURCE_GIT="https://github.com/bokobox/Nft.Platform.Static.git"
BE_BRANCH="dev"
BE_PROJECT_NAME="Nft.Platform.Static"
BE_STATIC_FOLDER="Nft.Platform.Static\src\Nft.Platform.Static\Public"

# echo git init
# git init
# git status
# git add --all
# git commit -m "update"
# echo git done
# [ -d "./.git" ] && echo "git init installed"
# ================
# APP CONFIG
RED='\033[0;31m'
NC='\033[0m' # No Color
# ================

# ========= check BE source ========= #
echo -e "${RED}[msg]${NC} check BE source folder..."
if [ -d $BE_PROJECT_NAME ]; then
    echo -e "${RED}[msg]${NC} clone $BE_PROJECT_NAME success"
else
    echo -e "${RED}[msg]${NC} start clone BE $BE_PROJECT_NAME"
    git clone $BE_SOURCE_GIT
    [ -d $BE_PROJECT_NAME ] && echo -e "${RED}[msg]${NC} clone $BE_PROJECT_NAME success"
fi
# ========= check FE source ========= #
echo -e "${RED}[msg]${NC} check Frontend source folder..."
if [ -d $FE_PROJECT_NAME ]; then
    echo -e "${RED}[msg]${NC} clone $FE_PROJECT_NAME success"
else
    echo -e "${RED}[msg]${NC} start clone BE $FE_PROJECT_NAME"
    git clone $FE_SOURCE_GIT
    [ -d $FE_PROJECT_NAME ] && echo -e "${RED}[msg]${NC} clone $FE_PROJECT_NAME success"
fi

# ========= Check AND BUILD FE ========= #
echo -e "${RED}[msg]${NC} move: go to FE source"
cd $FE_PROJECT_NAME
git status
git checkout .
git checkout $FE_BRANCH
git pull origin $FE_BRANCH
git reset --hard origin/$FE_BRANCH

echo -e "${RED}[msg]${NC} install: start install node_module FE project ..."
# create skip file fix bug react build
# add file .env
echo 'SKIP_PREFLIGHT_CHECK=true' > .env
npm install

# TODO: add file .env.development for react project
echo -e "${RED}[msg]${NC} build: start build FE project ..."
$FE_BUILD_COMMAND
cd ../
[ -d $FE_BUILD_FOLDER ] && echo -e "${RED}[msg]${NC} build: done build $FE_BUILD_FOLDER success..."

# ========= Prepare source BE ========= #
echo -e "${RED}[msg]${NC} move: go to BE source"
cd $BE_PROJECT_NAME
git status
git checkout .
git checkout $BE_BRANCH
git pull origin $BE_BRANCH
git reset --hard origin/$BE_BRANCH
cd ../

# ========= MERGE Frontend source to static folder ========= #
echo -e "${RED}[msg]${NC} COPY: process..."
if [ -d $FE_BUILD_FOLDER ]; then
    echo -e "${RED}[msg]${NC} COPY: start copy and merge project ..."
    cp -TRv $FE_BUILD_FOLDER $BE_STATIC_FOLDER
    echo -e "${RED}[msg]${NC} COPY: Done."
else
    echo -e "${RED}[msg]${NC} COPY: FAILED."
fi

# ========= create branch and create PR ========= #
echo -e "${RED}[msg]${NC} BRANCH_PR: create branch and PR"
cd $BE_PROJECT_NAME
git status
git add --all
git checkout -b $PR_VERSION
git commit -m $PR_VERSION
git push --set-upstream origin $PR_VERSION
gh pr create -w
git checkout $BE_BRANCH
cd ../
echo -e "${RED}[msg]${NC} BRANCH_PR: create branch $PR_VERSION success"