# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from matplotlib.colors import Normalize

import matplotlib.cm as cm


file = 'Data/elec_case_3_ef'

df = pd.read_csv(file)


data = df.to_numpy()


colors =-data[:,5]



norm = Normalize()
norm.autoscale(colors)
colormap = cm.jet


plt.quiver(data[:,2],data[:,3],data[:,7],data[:,8], color=colormap(norm(colors)))

