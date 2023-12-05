import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import numpy as np

from shared import init_plot, frame2quiver, frame_factory, update_quiver, skew
import colors

def rodrigues(omega_hat, theta):
    skew_omega_hat = skew(omega_hat)
    return np.eye(3) + np.sin(theta) * skew_omega_hat + (1 - np.cos(theta)) * (skew_omega_hat @ skew_omega_hat)

def R2EA(R):
    beta = np.arctan2(-R[2, 0], np.sqrt(R[0, 0] ** 2 + R[1, 0] ** 2))
    alpha = np.arctan2(R[1, 0] / np.cos(beta), R[0, 0] / np.cos(beta))
    gamma = np.arctan2(R[2, 1] / np.cos(beta), R[2, 2] / np.cos(beta))
    return np.array([alpha, beta, gamma], dtype=float)


def EA2R(EA):
    c = np.cos
    s = np.sin
    alpha = EA[0]
    beta = EA[1]
    gamma = EA[2]
    return np.array([
        [c(alpha) * c(beta), c(alpha) * s(beta) * s(gamma) - s(alpha) * c(gamma),
         c(alpha) * s(beta) * c(gamma) + s(alpha) * s(gamma)],
        [s(alpha) * c(beta), s(alpha) * s(beta) * s(gamma) + c(alpha) * c(gamma),
         s(alpha) * s(beta) * c(gamma) - c(alpha) * s(gamma)],
        [-s(beta), c(beta) * s(gamma), c(beta) * c(gamma)]
    ], dtype=float)


def i_omega_i_to_EA_dot(i_omega_i, EA):
    beta = EA[1]
    gamma = EA[2]
    return 1 / np.cos(beta) * np.array([
        [0, np.sin(gamma), np.cos(gamma)],
        [0, np.cos(gamma) * np.cos(beta), -np.sin(gamma) * np.cos(beta)],
        [np.cos(beta), np.sin(gamma) * np.sin(beta), np.cos(gamma) * np.sin(beta)]
    ], dtype=float) @ i_omega_i


def fake_algorithm_transl_vel(i, T):
    if i < 60:
        j_p_i_dot = np.array([0, -1, 0], dtype=float)
    else:
        i_v_i = np.array([2 * np.pi, 0, 0], dtype=float)
        j_p_i_dot = T[:3, :3] @ i_v_i
    return j_p_i_dot


# opseg = 2*r*pi = 3*pi
# 

def angular_velocity(i, j_T_i):
    if i < 360:
        i_omega_i = np.array([0, np.pi, 0], dtype=float)
    if i < 240:
        i_omega_i = np.array([np.pi, 0, 0], dtype=float)
    if i < 120:
        i_omega_i = np.array([0, 0, np.pi], dtype=float)

    return i_omega_i

def transl_velocity(i, j_T_i, dt):
    j_p_i_dot = (np.array([1.5*np.cos((i%120)*(2*np.pi/120)), 1.5*np.sin((i%120)*(2*np.pi/120)), 0], dtype=float) - j_T_i[:3, 3]) / dt
    return j_p_i_dot

def fake_algorithm_angular_vel(i):
    if i < 30:
        i_omega_i = np.array([2 * np.pi, 0, 0], dtype=float)
    elif i < 60:
        i_omega_i = np.array([0, -2 * np.pi, 0], dtype=float)
    else:
        i_omega_i = np.array([0, 0, -2 * np.pi], dtype=float)
    return i_omega_i


def another_fake_algorithm_transl_vel(i, T):
    i_v_i = np.array([0, 0, -2*np.pi / 12], dtype=float)
    i_v_i = (T[:3, 3] - np.array([1.5*np.cos((i%120)*(2*np.pi/120)),1.5*np.sin((i%120)*(2*np.pi/120)),0], dtype=float))
    j_p_i_dot = T[:3, :3] @ i_v_i
    return j_p_i_dot


def animate(i, frames, quivers, configurations, dt):
    move_i = True
    #move_k = False

    j_T_i = configurations[1]
    #i_T_k = configurations[2]

    if move_i:
        i_omega_i = angular_velocity(i, j_T_i) # np.array([0, np.pi / 12, 0], dtype=float)
        j_p_i_dot = transl_velocity(i, j_T_i, dt)

        j_omega_i = i_omega_i @ j_T_i[:3,:3].T
        omega_norm = np.linalg.norm(j_omega_i)
        theta = dt * omega_norm
        j_omega_i_hat = j_omega_i / omega_norm
        new_R = rodrigues(j_omega_i_hat, theta)

        #j_EA_i = R2EA(j_T_i[:3, :3])
        #j_EA_i += i_omega_i_to_EA_dot(i_omega_i, j_EA_i) * dt

        j_T_i[:3, :3] = j_T_i[:3, :3] @ new_R #EA2R(j_EA_i)
        j_T_i[:3, 3] += j_p_i_dot * dt
        configurations[1] = j_T_i

    #if move_k:

    #    k_omega_k = fake_algorithm_angular_vel(i)
    #    i_p_k_dot = fake_algorithm_transl_vel(i, i_T_k)

    #    i_omega_k = k_omega_k @ i_T_k[:3,:3].T
    #    omega_norm = np.linalg.norm(i_omega_k)
    #    theta = dt * omega_norm
    #    i_omega_k_hat = i_omega_k / omega_norm
    #    new_R = rodrigues(i_omega_k_hat, theta)
        #i_EA_k = R2EA(i_T_k[:3, :3])
        #i_EA_k += i_omega_i_to_EA_dot(k_omega_k, i_EA_k) * dt
        
    #    i_T_k[:3, :3] = i_T_k[:3, :3] @ new_R #EA2R(i_EA_k)
    #    i_T_k[:3, 3] += i_p_k_dot * dt
    #    configurations[2] = i_T_k

    update_quiver(frames[1] @ j_T_i.T, quivers[1])
    #update_quiver((frames[2] @ i_T_k.T) @ j_T_i.T, quivers[2])


if __name__ == "__main__":
    fig, ax = init_plot()

    num_frames = 360
    fps = 60
    dt = 1 / 60

    frame_j = frame_factory()
    j_T_j = np.eye(4, dtype=float)
    quiver_j = ax.quiver3D(*frame2quiver(frame_j), arrow_length_ratio=0, colors=colors.darkgray)

    frame_i = frame_factory()
    j_T_i = np.eye(4, dtype=float)
    j_T_i[0, 3] += 1.5
    quiver_i = ax.quiver3D(*frame2quiver(frame_i @ j_T_i.T), arrow_length_ratio=0, colors=[colors.red, colors.green, colors.blue])

    #frame_k = frame_factory()
    #i_T_k = np.eye(4, dtype=float)
    #quiver_k = ax.quiver3D(*frame2quiver((frame_k @ i_T_k.T) @ j_T_i.T), arrow_length_ratio=0, colors=[colors.cyan, colors.magenta, colors.orange])

    frames = [frame_j, frame_i]#, frame_k]
    quivers = [quiver_j, quiver_i]#, quiver_k]
    configurations = [j_T_j, j_T_i]#, i_T_k]

    ani = FuncAnimation(
        fig, 
        animate, 
        fargs=(frames, quivers, configurations, dt), 
        frames=num_frames,
        interval=dt * 1000, 
        repeat=False, 
        blit=False,
        init_func=lambda: None
    )
    
    plt.show()
