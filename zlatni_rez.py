# -*- coding: utf-8 -*-
"""
Created on Sat Apr  5 20:54:28 2025

@author: Korisnik
"""

import matplotlib.pyplot as plt
import numpy as np

def f(x):
    return abs(x - 1) + 2

[a0, b0] = [0,3]

t = np.linspace(a0, b0, 100)
plt.plot(t, f(t))
plt.show()

zr = (np.sqrt(5) + 1) / 2

x2i = b0 - (b0 - a0) / zr
x2i1 = a0 + (b0 - a0) / zr
plt.plot(t, f(t))
plt.plot([x2i1, x2i], [f(x2i1), f(x2i)], '.')
plt.show()

def zlatni_rez(f, a0, b0, num_steps=100):
    bi = b0
    ai = a0
    
    x2i = bi - (bi - ai) / zr
    fx2i = f(x2i)
    
    x2i1 = ai + (bi - ai) / zr
    fx2i1 = f(x2i1)
    
    for _i in range(num_steps):
        
        if fx2i < fx2i1:
            bi = x2i1
            x2i1 = x2i
            fx2i1 = fx2i
            
            x2i = bi - (bi - ai) / zr
            fx2i = f(x2i)
        else:
            ai = x2i
            x2i = x2i1
            fx2i = fx2i1
            
            x2i1 = ai + (bi - ai) / zr
            fx2i1 = f(x2i1)
            
    return ai

x_star = zlatni_rez(f, a0, b0)
plt.plot(t, f(t))
plt.plot([x_star], [f(x_star)], '.')
plt.show()
