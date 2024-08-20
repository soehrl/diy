package_version()
{
    echo "6.5"
}

package_build()
{
    BUILD_DIR=$1
    SHELF_DIR=$2

    cd $BUILD_DIR
    wget https://invisible-mirror.net/archives/ncurses/ncurses-6.5.tar.gz
    tar xvzf ncurses-6.5.tar.gz
    cd ncurses-6.5

    ./configure --prefix=$SHELF_DIR
    make -j
    make install
}
