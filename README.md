<h1 align="center">
  Curse of Knowing
</h1>

# Summary

This repository contains people and boxes.  The main one is the `base-image` figure.  This denotes which box your things are actually in.  Each person has two positions (labelled "you" and "person), and each position has three different conditions (labelled "ignorant", "know-plaus", and "know-implaus").

**Please use the `dev` branch when making changes, as Qualtrics is accessing the master branch.**

# Installation

Simply open terminal and run
```
git clone https://github.com/jakewilliami/tex-macros.git && echo "export PATH=\$PATH:$(pwd)/curse-of-knowing/" && chmod u+x curse-of-knowing/compile.sh && source ~/.bash_profile
```

# Making a pull request
While working in the `dev` branch, see [here](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/merging-a-pull-request).  To bring the `dev` branch up to date with `master` **after you have merged the pull request**, see [here](https://gist.github.com/santisbon/a1a60db1fb8eecd1beeacd986ae5d3ca).

# Recursively compiling figures

To complile each figure after changing the `*.tex` files in the main directory (in which this `README.md` is located), run the script `compile.sh`.  **This requires having LaTeX installed (see below).**

# Obtaining `TeXLive`

If you don't have a TeX version, I ran the following using `bash`
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
echo -e "\u001b[1;38;5;2mHomebrew installed successfully.\u001b[0;38m" && \
brew tap caskroom/cask && \
echo -e "\u001b[1;38;5;2mHomebrew cask installed successfully.\u001b[0;38m" && \
brew cask install mactex && \
echo -e "\u001b[1;38;5;2mTeXLive (TeX distribution) and MacTeX apps/tools installed successfully.\u001b[0;38m" && \
cd /tmp && \
curl --remote-name https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts && \
sudo texlua install-getnonfreefonts && \
sudo getnonfreefonts --sys --all && \
cd ${HOME} && \
echo -e "\u001b[1;38;5;2mFont \`garamondx\` installed successfully.\u001b[0;38m" && \
chmod u+x mktex
```

On my Linux machine I ran
```
sudo pacman -S texmaker texlive-most && \
echo -e "\u001b[1;38;5;2mTeXLive (TeX distribution) and a LaTeX Editor installed successfully.\u001b[0;38m" && \
cd /tmp && \
curl --remote-name https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts && \
sudo texlua install-getnonfreefonts && \
sudo getnonfreefonts --sys --all && \
cd ${HOME} && \
echo -e "\u001b[1;38;5;2mFont \`garamondx\` installed successfully.\u001b[0;38m" && \
chmod u+x mktex
```

## A note on `TeX`
It is around ~8 GB of space to download, so ensure you need it if you are to download it.
