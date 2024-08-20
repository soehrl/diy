package_version()
{
    echo "3.4"
}

package_build()
{
    BUILD_DIR=$1
    SHELF_DIR=$2

    cd $BUILD_DIR
    wget https://github.com/tmux/tmux/releases/download/3.4/tmux-3.4.tar.gz
    tar xvzf tmux-3.4.tar.gz
    cd tmux-3.4

    ./configure --prefix=$SHELF_DIR CFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/include/ncurses -L$HOME/.local/include"
    CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-static -L$HOME/.local/include -L$HOME/.local/include/ncurses -L$HOME/.local/lib" make -j
    make install
}
