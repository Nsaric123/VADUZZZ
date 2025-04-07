# -*- coding: utf-8 -*-
"""
Created on Sat Apr  5 20:58:00 2025

@author: Korisnik
"""

import matplotlib.pyplot as plt
import numpy as np

def f(x):
    return x**3 + 8*x**2 + 4

[a0,b0] = [-5,5]
x0 = 2

t = np.linspace(a0, b0, 100)
#plt.plot(t, f(t))
#plt.show()

def gradf(x):
    return 3*x**2 + 16*x

def hessf(x):
    return 6*x + 16

def newton(x0, f, gradf, hessf, num_steps=100):
    xi = x0
    for _i in range(num_steps):
        #plt.plot([xi], [f(xi)], '.')
        xi = xi - gradf(xi) / hessf(xi)
    
    return xi

x_star = newton(x0, f, gradf, hessf, num_steps=3)
plt.plot(t, f(t))
plt.plot([x_star], [f(x_star)], 'x')
plt.show()

x0 = -4
x_star = newton(x0, f, gradf, hessf, num_steps=3)
plt.plot(t, f(t))
plt.plot([x_star], [f(x_star)], 'x')
plt.show()

def secant(x0, x1, f, gradf, num_steps=100):
    xim1 = x0
    xi = x1
    for _i in range(num_steps):
        xip1 = xim1 - (xi-xim1) / (gradf(xi) - gradf(xim1)) * gradf(xim1)
        
        xim1 = xi
        xi = xip1
    
    return xi
x0 = 2
x1 = -2
x_star = secant(x0, x1, f, gradf, num_steps=10)
plt.plot(t, f(t))
plt.plot([x_star], [f(x_star)], '.')
plt.show()