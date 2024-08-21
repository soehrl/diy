package_version()
{
    echo "0.22.5"
}

package_build()
{
    BUILD_DIR=$1
    SHELF_DIR=$2

    cd $BUILD_DIR
    wget https://ftp.gnu.org/pub/gnu/gettext/gettext-0.22.5.tar.gz
    tar xvzf gettext-0.22.5.tar.gz
    cd gettext-0.22.5

    ./configure --prefix=$SHELF_DIR
    make -j
    make install
}
