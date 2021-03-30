#!/usr/bin/env bash

for condition in 'in_order' 'out_of_order'
do
    for file in $(ls "html/baseline/$condition")
    do
        ./apply_cmap.py "html/baseline/$condition/$file" \
                        "html/colormap/$condition/$file" \
                        --alpha 0.8 \
                        --cmap 'Blues'
    done
done
