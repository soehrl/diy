package_version()
{
    echo "0.10.1"
}

package_build()
{
    BUILD_DIR=$1
    SHELF_DIR=$2

    cd $BUILD_DIR
    wget https://github.com/neovim/neovim/archive/refs/tags/v0.10.1.tar.gz
    tar xzvf v0.10.1.tar.gz
    cd neovim-0.10.1
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$SHELF_DIR"
    make install
}
