if [ -d "$HOME/.diy" ]; then
    echo "Cannot install diy, the folder \`$HOME/.diy/\` already exists"
    exit 1
fi

git clone https://github.com/soehrl/diy.git "$HOME/.diy"

mkdir -p "$HOME/.local/bin"
ln -s "$HOME/.diy/diy.sh" "$HOME/.local/bin/diy"
