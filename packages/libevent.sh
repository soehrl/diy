package_version()
{
    echo "2.1.12-stable"
}

package_build()
{
    BUILD_DIR=$1
    SHELF_DIR=$2

    cd $BUILD_DIR
    cd $HOME/tmp/libevent
    wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
    tar xvzf libevent-2.1.12-stable.tar.gz
    cd libevent-2.1.12-stable

    ./configure --prefix=$SHELF_DIR
    make -j
    make install
}
