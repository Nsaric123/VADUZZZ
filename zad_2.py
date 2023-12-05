import tkinter
import numpy as np
import matplotlib.pyplot as plt
from shared import init_tkinter, add_slider, update_quiver_2D, frame2quiver_2D, frame_factory, A
import colors


def update(event, i, j):

    global configurations, quivers, lines

    # update variable theta/d
    joint_DH_params[i, j] = float(event)
    configurations[i] = A(joint_DH_params[i])
    

    for k in indices:
        # update frame
        b_T_i = np.eye(4, dtype=float)
        for i_T in indices[:k+1]:
            T = configurations[i_T]
            b_T_i = b_T_i @ T
        transformed = frame_scaled @ b_T_i.T
        update_quiver_2D(transformed, quivers[k])

        # update line
        if k > 0:   
            origin_prev = b_T_i_prev[:3, 3]
            origin_current = b_T_i[:3, 3]   
            lines[k-1].set_data(
                [origin_prev[0], origin_current[0]],
                [origin_prev[1], origin_current[1]]
            )
        b_T_i_prev = b_T_i

    fig.canvas.draw_idle()
    plt.pause(0.001)


if __name__ == "__main__":
    tk, fig, ax = init_tkinter()

    # Labels
    joint_labels = ["None", "theta_1", "theta_2"]


    # Infos: from, to, index of row in joint_DH_params, index of column in joint_DH_params, initial value
    theta_1_initial = np.pi * 3 / 4
    theta_2_initial = np.pi / 2

    joint_infos = np.array([
        [0, 0, 0, 3, 0],
        [0, np.pi / 2, 1, 3, theta_1_initial],
        [0, np.pi * 2 / 3, 2, 3, theta_2_initial]
    ], dtype=float)


    # Denavit–Hartenberg parameters
    a_1 = 0.75
    a_2 = 0.66

    joint_DH_params = np.array([
        [0, 0, 0, joint_infos[0][-1]],
        [a_1, 0, 0, joint_infos[1][-1]],
        [a_2, 0, 0, joint_infos[2][-1]]
    ], dtype=float)

    # Plot of a base frame
    frame_scale = 0.1
    frame = frame_factory()
    frame_scaled = frame_factory()
    frame_scaled[:, :3] *= frame_scale

    ax.quiver(
        *frame2quiver_2D(frame_scaled),
        color=[colors.red, colors.green],
        linewidth=4,
        headlength=0,
        headwidth=1,
    )


    # Plot of links' frames and lines
    configurations = [None for _ in joint_DH_params]
    quivers = [None for _ in joint_DH_params]
    lines = [None for _ in joint_DH_params[:-1]]

    indices = [0, 1, 2]
    slideable = [1, 2]

    for k in indices:
        # add frame at the end of a link
        configurations[k] = A(joint_DH_params[k])       
        b_T_i = np.eye(4, dtype=float)
        for i_T in indices[:k+1]:
            T = configurations[i_T]
            b_T_i = b_T_i @ T           
        transformed = frame_scaled @ b_T_i.T    
        quiver = ax.quiver(
            *frame2quiver_2D(transformed), 
            color=[colors.red, colors.green],
            linewidth=4,
            headlength=0,
            headwidth=1,
            zorder=1
        )
        quivers[k] = quiver

        # add lines that illustrate links
        if k > 0:
            origin_prev = b_T_i_prev[:3, 3]
            origin_current = b_T_i[:3, 3]   
            line = ax.plot(
                [origin_prev[0], origin_current[0]],
                [origin_prev[1], origin_current[1]],
                linewidth=5,
                solid_capstyle="round",
                color=colors.lightgray,
                alpha=0.5,
                zorder=0
            )[0]
            lines[k - 1] = line
        b_T_i_prev = b_T_i

        # add sliders if theta/d is variable
        if k in slideable:
            from_ = joint_infos[k][0]
            to = joint_infos[k][1]
            i = int(joint_infos[k][2])
            j = int(joint_infos[k][3])  
            add_slider(tk, joint_labels[k], callb=lambda event, i=i, j=j: update(event, i, j), from_=from_, to=to)

    
    tkinter.mainloop()