#!/usr/bin/env python3

import os
from argparse import ArgumentParser

import matplotlib.pyplot as plt
import numpy as np
from bs4 import BeautifulSoup
from matplotlib.colors import to_hex


def main(args):
    with open(args.in_file, 'r') as f:
        html = BeautifulSoup(f, 'html.parser')

    for style in html.head.find_all('style', type='text/css'):
        s = style.string
        s = s.replace('var(--jp-cell-prompt-not-active-opacity)', '1')
        s = s.replace('var(--jp-cell-prompt-not-active-font-color)', '#000')
        style.string = s

    cell_divs = html.body.find_all('div', class_='jp-Cell')
    cmap = plt.get_cmap(args.cmap)
    x = np.linspace(0, 1, num=len(cell_divs))

    for cell_div in cell_divs:
        in_div = cell_div.find('div', 'jp-InputPrompt')
        i = int(in_div.string[4:-2]) - 1
        color_hex = to_hex(cmap(x[i], alpha=args.alpha), keep_alpha=True)
        style = 'background-color: {}'.format(color_hex)
        in_div['style'] = style

        out_div = cell_div.find('div', 'jp-OutputPrompt')
        if out_div is not None:
            out_div['style'] = style

    os.makedirs(os.path.dirname(args.out_file), exist_ok=True)
    with open(args.out_file, 'w') as f:
        f.write(html.prettify())


if __name__ == '__main__':
    parser = ArgumentParser()

    parser.add_argument(
        'in_file',
        help='path of an HTML file to which the color map should be '
             'applied')
    parser.add_argument(
        'out_file',
        help='file path where the resulting HTML file should be saved')

    parser.add_argument(
        '-a', '--alpha', default=0.8, type=float,
        help='an alpha (a number between 0.0 and 1.0) to apply to the '
             'color map')
    parser.add_argument(
        '-c', '--cmap', default='Blues',
        help='name of a Matplotlib color map (see '
             'https://matplotlib.org/stable/tutorials/colors/colormaps.html '
             'for a list of options)')

    main(parser.parse_args())
