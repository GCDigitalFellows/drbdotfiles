#!/usr/bin/env bash

# to-do: install via anaconda
# to-do: install basemap, cartopy
pips=(
  -c\ scitools\ cartopy
  jupyter
  matplotlib
  nltk
  numpy
  pandas
  pillow
  -c\ scitools\ pyshp
  scipy
  shapely
  scikit-learn
)

for pip in "${pips[@]}"; do
  conda install -y "$pip"
  # pip2 install "$pip" -U
  # pip3 install "$pip" -U
done
