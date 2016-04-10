#!/usr/bin/env bash

# to-do: install via anaconda
# to-do: install basemap, cartopy
pips=(
  jupyter
  matplotlib
  nltk
  numpy
  pandas
  pillow
  pyshp
  scipy
  shapely
  shapy
  sklearn
  virtualenv
)

condas=(
  scitools
  cartopy
)

for pip in "${pips[@]}"; do
  pip install "$pip" -U
done

for cnda in "${condas[@]}"; do
  conda install -c "$cnda" -y
done
