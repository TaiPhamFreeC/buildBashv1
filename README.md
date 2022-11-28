# buildBashv1

# Install
using to create PR from terminal Github.cli
basic install find here: https://github.com/cli/cli#installation

## window install
1. open `cmd`.
2. enter `winget install --id GitHub.cli`.
3. success, check your install enter `gh --version`.
## window github login
1. open `cmd`.
2. enter `gh auth login` to login.
3. ...

# How to run
open git bash, enter `./build.sh` to run build

# Configuations:
```js
PR_VERSION=v1.0.33-dev //<~~~~ version to build

FE_SOURCE_GIT="https://github.com/bokobox/animap-web.git"
FE_BRANCH="develop" //<~~~~ branch name
FE_PROJECT_NAME="animap-web"
FE_BUILD_FOLDER="animap-web\build"

FE_BUILD_COMMAND="npm run build:dev" //<~~~~ BUILD COMMAND


BE_SOURCE_GIT="https://github.com/bokobox/Nft.Platform.Static.git"
BE_BRANCH="dev" //<~~~~ branch name
BE_PROJECT_NAME="Nft.Platform.Static"
BE_STATIC_FOLDER="Nft.Platform.Static\src\Nft.Platform.Static\Public"
```