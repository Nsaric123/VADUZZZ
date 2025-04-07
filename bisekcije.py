import numpy as np
import matplotlib.pyplot as plt

# primjer 1
def f(x):
    return x/2 + 1/x

[a0,b0] = [1,4]

t = np.linspace(1,4,100)
#plt.plot(t, f(t))
#splt.show()

def gradf(x):
    return 1/2 - 1/x**2

def bisection_method(gradf, a0, b0, num_steps=100):
    ai = a0
    bi = b0
    for _i in range(num_steps):
        xi = (ai + bi) / 2
        plt.plot(xi, f(xi), '.b')
        if gradf(xi) < 0:
            ai = xi
        else:
            bi = xi
    return ai

x_star = bisection_method(gradf, a0, b0)
print('x_star =', x_star, 'f(x_star) =', f(x_star))
plt.plot(t, f(t))
#plt.plot(x_star, f(x_star), '.')
plt.show()

eps = 0.05
k = int(np.ceil(-np.log2(eps / (b0 - a0))))
x_star_k = bisection_method(gradf, a0, b0, k)
print('|ai - x_star| =', abs(x_star_k - x_star))
print('|f(ai) - f(x_star)| =', abs(f(x_star_k) - f(x_star)))

print('Za eps =', eps, 'trebamo k =', k, 'koraka najvise.')
L = max(abs(gradf(a0)), abs(gradf(b0)))
print('L =', L)
k2 = int(np.ceil(-np.log2(eps/ L / abs(a0 - b0))))
print('k2 =', k2)
x_star_k2 = bisection_method(gradf, a0, b0, k2)
print('|ai - x_star| =', abs(x_star_k2 - x_star))
print('|f(ai) - f(x_star)| =', abs(f(x_star_k2) - f(x_star)))

print()


def bisection_method_nograd(f, a0, b0, num_steps=100, delta=0.0005):
    ai = a0
    bi = b0
    for _i in range(num_steps):
        x2i = (ai+bi)/2 - delta
        x2i1 = (ai+bi) / 2 + delta
        plt.plot(x2i, f(x2i), '.r')
        plt.plot(x2i1, f(x2i1), '.g')
        
        if f(x2i) < f(x2i1):
            bi = x2i1
        else:
            ai = x2i
    
    return ai

eps = 0.05
delta = 0.005
k = int(np.ceil(-np.log2(eps / (b0 - a0) - 2*delta)))
x_star_k = bisection_method_nograd(f, a0, b0, k, delta=delta)
print('|ai - x_star| =', abs(x_star_k - x_star))
print('|f(ai) - f(x_star)| =', abs(f(x_star_k) - f(x_star)))

plt.show()

print('Za eps =', eps, 'trebamo k =', k, 'koraka najvise.')
L = max(abs(gradf(a0)), abs(gradf(b0)))
print('L =', L)
k2 = int(np.ceil(-np.log2((eps/ abs(a0 - b0) - 2*delta))/L))
print('k2 =', k2)
x_star_k2 = bisection_method_nograd(f, a0, b0, k2)
print('|ai - x_star| =', abs(x_star_k2 - x_star))
print('|f(ai) - f(x_star)| =', abs(f(x_star_k2) - f(x_star)))