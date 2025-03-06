#!/bin/bash
# 자주 사용하는 lazyvim의 초기 설치 스크립트입니다. - mac, ubuntu 버전

# ✅ OS 확인
OS="$(uname -s)"

# ✅ MacOS라면 Homebrew 설치 확인 후 설치
install_homebrew_if_mac() {
    if [ "$OS" == "Darwin" ]; then
        if ! command -v brew &> /dev/null; then
            echo "⚡️ Homebrew가 설치되지 않음. 설치를 시작합니다..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
            echo "✅ Homebrew 설치 완료!"
        else
            echo "✅ Homebrew가 이미 설치됨"
        fi
    fi
}

# ✅ 패키지 설치 확인 및 설치 함수
install_if_needed() {
    local cmd=$1
    local package_mac=$2
    local package_ubuntu=$3
    local version_flag=$4

    if command -v $cmd &> /dev/null; then
        echo "✅ $cmd 설치됨: $($cmd $version_flag)"
    else
        echo "🚀 $cmd 설치 중..."
        if [ "$OS" == "Darwin" ]; then
            brew install $package_mac
        elif [ "$OS" == "Linux" ]; then
            if  [ $package_ubuntu == 'fzf' ]; then
                git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
                ~/.fzf/install
            elif [ $package_ubuntu == 'fd-find' ]
                wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd_8.4.0_amd64.deb
                sudo dpkg -i fd_8.4.0_amd64.deb
            elif [ $package_ubuntu == 'neovim' ]
                curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
                sudo rm -rf /opt/nvim
                sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
                echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
                source ~/.bashrc
            else
                sudo apt update && sudo apt install -y $package_ubuntu
            fi
        fi
    fi
}

echo "⚡️ LazyVim 필수 패키지 설치 스크립트 시작..."

# ✅ MacOS라면 Homebrew 설치 체크
install_homebrew_if_mac

# ✅ 필수 패키지 목록 설치 (MacOS → brew / Ubuntu → apt 사용)
install_if_needed "nvim" "neovim" "neovim" "--version"
install_if_needed "git" "git" "git" "--version"
install_if_needed "lazygit" "lazygit" "lazygit" "--version"
install_if_needed "gcc" "gcc" "gcc" "--version"
install_if_needed "curl" "curl" "curl" "--version"
install_if_needed "fzf" "fzf" "fzf" "--version"
install_if_needed "rg" "ripgrep" "ripgrep" "--version"
install_if_needed "fd" "fd" "fd-find" "--version"

echo "✅ LazyVim 필수 패키지 설치 완료! 🎉"


# required
mv ~/.config/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
