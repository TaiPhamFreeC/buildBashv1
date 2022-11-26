# buildBashv1
open git bash, enter `./build.sh` to run build

# first setup
```
PR_VERSION=v1.0.33-dev <~~~~ version to build

FE_SOURCE_GIT="https://github.com/bokobox/animap-web.git"
FE_BRANCH="develop" <~~~~ branch name
FE_PROJECT_NAME="animap-web"
FE_BUILD_FOLDER="animap-web\build"
FE_BUILD_COMMAND="npm run build:dev"

BE_SOURCE_GIT="https://github.com/bokobox/Nft.Platform.Static.git"
BE_BRANCH="dev" <~~~~ branch name
BE_PROJECT_NAME="Nft.Platform.Static"
BE_STATIC_FOLDER="Nft.Platform.Static\src\Nft.Platform.Static\Public"
```