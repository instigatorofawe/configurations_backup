# Ubuntu desktop 

## Git configuration
```
git config --global user.name "Ran Liu"
git config --global user.email "xabsox@gmail.com"
git config --global core.editor "nvim"
```

## Software: 
- git (apt)
- i3 (apt)
- tmux (apt)
- R (CRAN, apt)
- Dependencies for tidyverse, other R libraries (apt): `sudo apt install libssl-dev libcurl4-openssl-dev unixodbc-dev libxml2-dev libmariadb-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev`
- Dependencies for flextable `sudo apt install libfontconfig1-dev libcairo2-dev libblas-dev liblapack-dev`
- picom (apt)
- xclip (apt)
- maim (apt)
- nitrogen (apt)
- htop (snap)
- nvtop (snap)
- nvim (snap)
- rustup (snap)
- alacritty (cargo install)
- google-chrome (.deb)
- rstudio (.deb)
- vscode (code) (.deb)
- Patched fonts (DejaVuSans Monospace)

## Tmux setup
From [https://github.com/tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Miniforge install
See [https://github.com/conda-forge/miniforge](https://github.com/conda-forge/miniforge)
