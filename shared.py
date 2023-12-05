import matplotlib.pyplot as plt
import numpy as np
import tkinter
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk
from matplotlib.figure import Figure


def frame_factory():
    return np.array([
        [0, 0, 0, 1],
        [1, 0, 0, 1],
        [0, 1, 0, 1],
        [0, 0, 1, 1]
    ], dtype=float)


def init_plot(fig=None, lim_from=-3, lim_to=3):
    if fig is None:
        fig = plt.figure(figsize=(8, 8))
    ax = fig.add_subplot(projection='3d')
    ax.view_init(azim=30, elev=20)
    ax.set_box_aspect((1, 1, 1))
    ax.set_xlim3d([lim_from, lim_to])
    ax.set_ylim3d([lim_from, lim_to])
    ax.set_zlim3d([lim_from, lim_to])
    ax.set_xlabel("$x_j$")
    ax.set_ylabel("$y_j$")
    ax.set_zlabel("$z_j$")

    return fig, ax


def init_plot_2D(fig=None, lim_from=-2, lim_to=2):
    if fig is None:
        fig = plt.figure(figsize=(8, 8))
    ax = fig.add_subplot()
    ax.set_box_aspect(1)
    ax.set_xlim([lim_from, lim_to])
    ax.set_ylim([lim_from, lim_to])
    ax.set_xlabel("$x_I$")
    ax.set_ylabel("$y_I$")

    ax.set_axisbelow(True)
    ax.grid()

    return fig, ax


def frame2quiver(frame, diff=1):
    # diff jer u, v i w u quiver3D mora biti razlika krajnje
    # i početne točke. Matplotlib je pomalo nekonzistentan -
    # pri update-anju strelica (poziv fje quiver.set_segments)
    # ne traži se razlika krajnje i početne točke već krajnja i početna
    # točka. Tad će diff biti 0
    x = np.repeat(frame[0, 0], 3)
    y = np.repeat(frame[0, 1], 3)
    z = np.repeat(frame[0, 2], 3)
    u = frame[1:, 0] - frame[0, 0] * diff
    v = frame[1:, 1] - frame[0, 1] * diff
    w = frame[1:, 2] - frame[0, 2] * diff
    return x, y, z, u, v, w


def update_quiver(frame, quiver):
    segs = np.array(frame2quiver(frame, diff=0)).reshape(6, -1)
    new_segs = [[[x, y, z], [u, v, w]] for x, y, z, u, v, w in zip(*segs.tolist())]
    quiver.set_segments(new_segs)


def frame2quiver_2D(frame, diff=1):
    x = np.repeat(frame[0, 0], 2)
    y = np.repeat(frame[0, 1], 2)
    u = frame[1:3, 0] - frame[0, 0] * diff
    v = frame[1:3, 1] - frame[0, 1] * diff
    return x, y, u, v


def update_quiver_2D(frame, quiver):
    segs = np.array(frame2quiver_2D(frame, diff=0)).reshape(4, -1)
    new_segs_xy = [[x, y] for x, y, u, v in zip(*segs.tolist())]
    x, y, u, v = frame2quiver_2D(frame, diff=1)
    quiver.set_offsets(new_segs_xy)
    quiver.set_UVC(u, v)


def frame2quiver_2D(frame, diff=1):
    x = np.repeat(frame[0, 0], 2)
    y = np.repeat(frame[0, 1], 2)
    u = frame[1:3, 0] - frame[0, 0] * diff
    v = frame[1:3, 1] - frame[0, 1] * diff
    return x, y, u, v


def update_quiver_2D(frame, quiver):
    segs = np.array(frame2quiver_2D(frame, diff=0)).reshape(4, -1)
    new_segs_xy = [[x, y] for x, y, u, v in zip(*segs.tolist())]
    x, y, u, v = frame2quiver_2D(frame, diff=1)
    quiver.set_offsets(new_segs_xy)
    quiver.set_UVC(u, v)

def A(DH_params):
    a, alpha, d, theta = DH_params[0], DH_params[1], DH_params[2], DH_params[3]
    return np.array([
        [
            np.cos(theta),
            -np.sin(theta) * np.cos(alpha),
            np.sin(theta) * np.sin(alpha),
            a * np.cos(theta)
        ],
        [
            np.sin(theta),
            np.cos(theta) * np.cos(alpha),
            -np.cos(theta) * np.sin(alpha),
            a * np.sin(theta)
        ],
        [
            0,
            np.sin(alpha),
            np.cos(alpha),
            d
        ],
        [0, 0, 0, 1]
    ], dtype=float)

def Rot_z(theta):
    return np.array([
        [np.cos(theta), -np.sin(theta), 0, 0],
        [np.sin(theta), np.cos(theta), 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ], dtype=float)

def T_inv(T):
    T_ = np.eye(4, dtype=float)
    T_[:3, :3] = T[:3, :3].transpose()
    T_[:3, 3] = -T[:3, :3].transpose() @ T[:3, 3]
    return T_

def skew(v):
    return np.array([
        [0, -v[2], v[1]],
        [v[2], 0, -v[0]],
        [-v[1], v[0], 0]
    ], dtype=float)

# predavanje 4, slide 18
def R(theta):
    return np.array([
        [np.cos(theta), np.sin(theta), 0],
        [-np.sin(theta), np.cos(theta), 0],
        [0, 0, 1]
    ], dtype=float)

# without last mask
wlm = np.array([1, 1, 0], dtype=float)

def init_tkinter(two_dim=True):
    tk = tkinter.Tk()
    tk.wm_title("IRS: Direktna kinematika robotske ruke")

    plt.ion()
    fig = Figure()
    img = tkinter.Frame(tk)

    canvas = FigureCanvasTkAgg(fig, master=img)
    canvas.draw()
    canvas.get_tk_widget().pack(side=tkinter.TOP, fill=tkinter.BOTH, expand=1)

    img.pack(side="left")

    if two_dim:
        fig, ax = init_plot_2D(fig)
    else:
        fig, ax = init_plot(fig)

    toolbar = NavigationToolbar2Tk(canvas, tk)
    toolbar.update()
    canvas.get_tk_widget().pack(side=tkinter.TOP, fill=tkinter.BOTH, expand=1)    
    return tk, fig, ax


def add_slider(tk, label_text, callb, from_, to, initial_value=None):

    # ovako za svaki slider
    f = tkinter.Frame(tk)
    l = tkinter.Label(f, text=label_text)
    l.pack(side="left", pady=(14, 0))
    s = tkinter.Scale(
        master=f, from_=from_, to=to, resolution=0.01, orient=tkinter.HORIZONTAL, length=450,
        command=callb)
    
    if initial_value is None:
        initial_value = (from_ + to) / 2

    s.set(initial_value)
    s.pack(side="right")
    f.pack()