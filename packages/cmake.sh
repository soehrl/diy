package_version()
{
    echo "3.20.2"
}

package_build()
{
    BUILD_DIR=$1
    SHELF_DIR=$2

    cd $BUILD_DIR
    wget https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2.tar.gz
    tar xvzf cmake-3.30.2.tar.gz
    cd cmake-3.30.2

    ./configure --prefix=$SHELF_DIR --parallel=$(nproc --all)
    make -j
    make install
}
