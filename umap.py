#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep  3 14:08:06 2021

@author: lfelce

UMAP test

press F9 to run code line by line!

https://umap-learn.readthedocs.io/en/latest/basic_usage.html
"""

import numpy as np
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
%matplotlib inline

# penguins = pd.read_csv("https://github.com/allisonhorst/palmerpenguins/raw/5b5891f01b52ae26ad8cb9755ec93672f49328a8/data/penguins_size.csv")
# penguins.head()
# penguins = penguins.dropna()
# penguins.species_short.value_counts()
# sns.pairplot(penguins, hue='species_short')
# import umap
# reducer = umap.UMAP()
# penguin_data = penguins[
#     [
#         "culmen_length_mm",
#         "culmen_depth_mm",
#         "flipper_length_mm",
#         "body_mass_g",
#     ]
# ].values
# scaled_penguin_data = StandardScaler().fit_transform(penguin_data)
# embedding = reducer.fit_transform(scaled_penguin_data)
# embedding.shape

data = pd.read_csv("/stopgap/donglab/ling/R/test/total_python.csv")
data.head()
list(data.columns)

data = data.dropna()
data.Sample.value_counts()

# sns.pairplot(data, hue='Sample')

import umap

reducer = umap.UMAP()

data2 = data[
    [
        "Count_A",
        "Count_B",
        "Count_C",
        "Diameter",
        "Density_A",
        "Density_B",
        "Density_C",
        "AB_NN",
        "AC_NN",
        "BC_NN",
    ]
].values
scaled_data = StandardScaler().fit_transform(data2)
embedding = reducer.fit_transform(scaled_data)
embedding.shape

plt.scatter(
    embedding[:, 0],
    embedding[:, 1],
    s=5,
    c=[sns.color_palette()[x] for x in data.Sample.map({"S1":0, "S2":1, "S3":2, "S4":3, "S5":4})])
plt.gca().set_aspect('equal', 'datalim')
plt.title('UMAP projection of the test dataset', fontsize=15)


