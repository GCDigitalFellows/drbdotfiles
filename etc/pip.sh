#!/usr/bin/env bash

# to-do: install via anaconda
# to-do: install basemap, cartopy
pips=(
  cartopy
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

# condas=(
#   scitools
# )

for pip in "${pips[@]}"; do
  conda install "$pip" -y
  # pip2 install "$pip" -U
  # pip3 install "$pip" -U
done

# for cnda in "${condas[@]}"; do
#   conda install "$cnda" -y
# done

