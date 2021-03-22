#!/usr/bin/env python3

from argparse import ArgumentParser

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import to_hex

URL = 'https://matplotlib.org/stable/tutorials/colors/colormaps.html'


def main(args):
    cmap = plt.get_cmap(args.cmap)
    for x in np.linspace(0, 1, num=args.n_colors):
        print(to_hex(cmap(x), keep_alpha=False))


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
