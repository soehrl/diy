#!/bin/sh

# set -e
ROOT_DIR=.
PWD=$(pwd)
INSTALL_PREFIX=$HOME/.local

link()
{
    PACKAGE_NAME=$1
    SHELF_DIR="$HOME/.diy/shelf/${PACKAGE_NAME}"

    if [ -d "$SHELF_DIR" ]; then
        for DIR in $SHELF_DIR/*
        do
            DIR_NAME="${DIR##*/}" 
            INSTALL_DIR="$INSTALL_PREFIX/$DIR_NAME"

            mkdir -p $INSTALL_DIR

            for DIR_CONTENT in $DIR/*
            do
                CONTENT_NAME="${DIR_CONTENT##*/}" 
                echo "Linking $INSTALL_DIR/$CONTENT_NAME -> $DIR_CONTENT"
                ln -s "$DIR_CONTENT" "$INSTALL_DIR/$CONTENT_NAME"
            done
        done
    else
        echo "Cannot link \`$PACKAGE_NAME\` it is not built yet."
        return 1
    fi
}

unlink()
{
    PACKAGE_NAME=$1
    SHELF_DIR="$HOME/.diy/shelf/${PACKAGE_NAME}"

    if [ -d "$SHELF_DIR" ]; then
        for DIR in $SHELF_DIR/*
        do
            DIR_NAME="${DIR##*/}" 
            INSTALL_DIR="$INSTALL_PREFIX/$DIR_NAME"

            mkdir -p $INSTALL_DIR

            for DIR_CONTENT in $DIR/*
            do
                CONTENT_NAME="${DIR_CONTENT##*/}" 
                INSTALLED_CONTENT=$INSTALL_DIR/$CONTENT_NAME
                LINK=$(readlink "$INSTALLED_CONTENT")
                if [ "$LINK" = "$DIR_CONTENT" ]; then
                    echo "Unlink $INSTALLED_CONTENT"
                    rm $INSTALLED_CONTENT
                else
                    echo "Do not unlink $INSTALLED_CONTENT: incorrect target"
                fi
            done
        done
    else
        echo "Cannot link \`$PACKAGE_NAME\` it is not built yet."
        return 1
    fi
}

build()
{
    PACKAGE_NAME=$1
    PACKAGE_SCRIPT="${ROOT_DIR}/packages/$PACKAGE_NAME.sh"
    if [ -f "$PACKAGE_SCRIPT" ]; then
        source $PACKAGE_SCRIPT
        echo "Installing '${PACKAGE_NAME}'@v$(package_version)"

        SHELF_DIR="$HOME/.diy/shelf/${PACKAGE_NAME}"
        if [ -d "$SHELF_DIR" ]; then
            echo "${PACKAGE_NAME} is already built. Use \`diy remove ${PACKAGE_NAME}\` to remove it first."
            return 1
        fi

        BUILD_DIR="$HOME/.diy/workbench/${PACKAGE_NAME}"
        if [ -d "$BUILD_DIR" ]; then
            echo "Clean build directory."
            rm -rf $BUILD_DIR
        fi
        mkdir -p $BUILD_DIR $SHELF_DIR

        package_build $BUILD_DIR $SHELF_DIR
        if [ $? -eq 0 ]; then
            echo "Successfully built $PACKAGE_NAME"
            link $PACKAGE_NAME
            echo "Clean up workbench"
            rm -rf $BUILD_DIR
            echo "All done"
        else
            echo "Failed to build ${PACKAGE_NAME}"
            return 1
        fi
    else
        echo "Cannot find package '${PACKAGE_NAME}'"
    fi
}

remove()
{
    PACKAGE_NAME=$1
    SHELF_DIR="$HOME/.diy/shelf/${PACKAGE_NAME}"
    if [ -d "$SHELF_DIR" ]; then
        unlink $PACKAGE_NAME
        echo "Remove $SHELF_DIR"
        rm -rf $SHELF_DIR
    else
        echo "$PACKAGE_NAME is not built."
        return 1
    fi
}

case $1 in
  build)
    build $2
    ;;

  remove)
    remove $2
    ;;

  link)
    link $2
    ;;

  unlink)
    unlink $2
    ;;

  *)
    echo help
    ;;
esac
