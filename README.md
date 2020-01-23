<h1 align="center">
  Curse of Knowing
</h1>

# Summary

This repository contains people and boxes.  Each person has two positions (labelled "you" and "person), and each position has three different conditions (labelled "ignorant", "know-plaus", and "know-implaus").

# Installation

Simply run
```
cd ${HOME} && git clone https://github.com/jakewilliami/tex-macros.git
```

# Recursively compiling figures

To complile each figure after changing the `*.tex` files in the main directory (in which this `README.md` is located), run the following

```
for figure in $(find . -name fig.tex -type f -print); do
    cd `dirname ${figure}` && texfot pdflatex fig.tex; cd -
done
```

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
