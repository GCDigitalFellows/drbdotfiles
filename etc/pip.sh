#!/usr/bin/env bash

# to-do: install via anaconda
# to-do: install basemap, cartopy
pips=(\
flask \
jupyter \
matplotlib \
neovim \
nltk \
numpy \
pandas \
pillow \
pyshp \
scipy \
shapely \
shapy \
sklearn \
)
for pip in $pips; do
  pip install $pip -U
done

conda install -c scitools cartopy -y
