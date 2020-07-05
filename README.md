# linux-how-to
## Table of Contents
- [About and Disclaimer](#about-and-disclaimer)
- [Steps](#steps)
- [Author](#author)
- [License](#license)
## About and Disclaimer
This repository is merely for personal use. It's not private since someone might find it useful and, even for me, it saves the pain of login while in a strangers computer.

The purpose of this reposity is when I start a freshly Linux image, a bit more than just dotfiles. If you want to use it, do it at your own risk.

Also, most of this steps are copy & paste from their respective installation guides.
## Steps
1. Install [Git](https://git-scm.com/)
    ```
    $ sudo apt-get install git -y
    ```
    ```
    $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    # Save it to /home/your-user-here/.ssh/GitHub
    ```
    ```
    $ echo -e "Host github.com\n    Hostname ssh.github.com\n    IdentityFile ~/.ssh/GitHub.pub\n    Port 443 #Only if the default 22 is blocked" > ~/.ssh/config
    # Remove port option if possible
    ```
2. Clone this repo with submodules and move it to $HOME
    ```
    $ git clone --recurse-submodules -j8 git@github.com:Guergeiro/linux-how-to.git
    ```
    ```
    $ cp -r linux-how-to/.vim $HOME/
    $ cp .bash_aliases $HOME/
    $ cp .vimrc $HOME/
    ```
3. Update everything
    ```
    $ update
    ```
4. Install [Vim](https://www.vim.org/)
    ```
    $ sudo apt-get install vim vim-gtk -y
    ```
5. Install [Nerd Fonts](https://nerdfonts.com) (Required for VIM Plugin)
    ```
    $ linux-how-to/nerd-fonts/install.sh
    ```
6. Install [cURL](https://curl.haxx.se/)
    ```
    $ sudo apt-get install curl -y
    ```
7. Install [Deno](https://deno.land)
    ```
    $ curl -fsSL https://deno.land/x/install/install.sh | sh
    ```
    ```
    $ sudo mv $HOME/.deno/bin/deno /usr/bin/
    ```
8. Install [Node](https://nodejs.org/) (change **Y** to current LTS)
    ```
    $ curl -sL https://deb.nodesource.com/setup_Y.x | sudo -E bash -
    ```
    ```
    $ update
    ```
    ```
    $  sudo apt-get install nodejs -y
    ```
9. Install [TypeScript](https://www.typescriptlang.org/)
    ```
    $ sudo npm install -g typescript
    ```
10. Install [Python](https://www.python.org/) (version 3)
    ```
    $ sudo apt-get install python3 -y
    ```
11. Install [OpenJDK](http://openjdk.java.net/)
    ```
    $ sudo apt-get install default-jdk-headless -y
    ```
12. Install [Docker](https://www.docker.com/)
    ```
    $ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    ```
    ```
    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```
    ```
    $ sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    ```
    ```
    $ update
    ```
    ```
    $ sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    ```
    ```
    $ sudo usermod -aG docker your-user-here
    ```
13. Install [VisualStudioCodium](https://vscodium.com/) (If you want VSCode)
    ```
    $ wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
    ```
    ```
    $ echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
    ```
    ```
    $ update
    ```
    ```
    $ sudo apt-get install codium -y
    ```
    With the following extensions:
    - [Vim](https://github.com/VSCodeVim/Vim)
    - [Live Server](https://github.com/ritwickdey/vscode-live-server)
    - [Material Icon Theme](https://github.com/PKief/vscode-material-icon-theme)
    - [Debugger for Java](https://github.com/Microsoft/vscode-java-debug)
    - [Java Dependency Viewer](https://github.com/Microsoft/vscode-java-dependency)
    - [Java Test Runner](https://github.com/Microsoft/vscode-java-test)
    - [Language Support for Java(TM) by Red Hat](https://github.com/redhat-developer/vscode-java)
    - [Maven for Java](https://github.com/Microsoft/vscode-maven)
    - [Python](https://github.com/Microsoft/vscode-python)
## Author
Created by [Breno Salles](https://brenosalles.com).
## License
This repository is licensed under [MIT License](./LICENSE).
