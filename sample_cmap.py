#!/usr/bin/env python3

from argparse import ArgumentParser

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import to_hex

URL = 'https://matplotlib.org/stable/tutorials/colors/colormaps.html'


def main(args):
    colors = plt.get_cmap(args.cmap).colors
    indices = np.linspace(0, len(colors) - 1, num=args.n_colors)
    for i in indices:
        i = int(np.round(i))
        print(to_hex(colors[i]))


if __name__ == '__main__':
    parser = ArgumentParser()

    parser.add_argument(
        'cmap',
        help='name of a Matplotlib color map (see {} for a list of '
             'options)'.format(URL))
    parser.add_argument(
        'n_colors', type=int,
        help='number of colors to sample from the color map')

    main(parser.parse_args())
