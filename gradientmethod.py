# -*- coding: utf-8 -*-
"""
Created on Sat Apr  5 21:01:10 2025

@author: Korisnik
"""

import numpy as np
import matplotlib.pyplot as plt

A = np.array([
        [2,3],
        [1,3]
        ])
b = np.array([1, -1])

def f(x):
    return np.linalg.norm(A@x - b)**2

x = np.linspace(-5,5, 100)
y = np.linspace(-5,5, 100)
X, Y = np.meshgrid(x, y)
X = X.reshape(-1)
Y = Y.reshape(-1)
Z = np.array([ f(np.array([x,y])) for (x,y) in zip(X,Y) ])
plt.contour(X.reshape(100,100), Y.reshape(100,100), Z.reshape(100,100), levels=np.logspace(-3,6,15, base=3))

def g(x):
    return 2*A.T@(A@x - b)

def gradient_method(x0, g, num_steps=100):
    step_size = 1/(2*np.linalg.norm(A.T@A))
    for _i in range(num_steps):
        #plt.plot([x0[0]], [x0[1]], '.')
        x0 = x0 - step_size * g(x0)

    return x0

x0 = np.array([-5, -5])
x_star = gradient_method(x0, g)
print(g(x_star))
print(f(np.array([0,0])))
print(x_star)
plt.plot([x_star[0]], [x_star[1]], 'x')
plt.show()

def f(x):
    return np.exp(x[0] + 2) + np.exp(-x[0] + 2) + 2*np.exp(x[1] + 2) + np.exp(-x[1] + 2)

x = np.linspace(-5,5, 100)
y = np.linspace(-5,5, 100)
X, Y = np.meshgrid(x, y)
X = X.reshape(-1)
Y = Y.reshape(-1)
Z = np.array([ f(np.array([x,y])) for (x,y) in zip(X,Y) ])
#plt.contour(X.reshape(100,100), Y.reshape(100,100), Z.reshape(100,100), levels=np.logspace(-3,6,15, base=3))

def gradient_method_fixed(x0, g, num_steps=100):
    step_size = 0.0005
    for _i in range(num_steps):
        plt.plot([x0[0]], [x0[1]], '.')
        x0 = x0 - step_size * g(x0)

    return x0

def g(x):
    return np.array([
                np.exp(x[0]+2) - np.exp(-x[0]+2),
                2*np.exp(x[1] + 2) - np.exp(-x[1]+2)
            ])

x0 = np.array([-5, -5])
x_star = gradient_method_fixed(x0, g)
#print(x_star)
#plt.plot([x_star[0]], [x_star[1]], 'x')
#plt.show()