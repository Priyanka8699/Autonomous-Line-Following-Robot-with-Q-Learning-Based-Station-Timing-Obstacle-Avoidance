# 🚗 Autonomous Line-Following Robot with Q-Learning-Based Station Timing & Obstacle Avoidance

This project presents a hybrid autonomous ground vehicle that follows a black line path, intelligently waits at stations using **Q-learning** for optimized wait durations, and dynamically avoids obstacles using ultrasonic sensors.

## 📌 Project Overview

We developed an Arduino-based robot capable of:
- Following a black line using IR sensors.
- Detecting and avoiding obstacles using ultrasonic sensors.
- Learning optimal wait times at different stations using **Q-learning** reinforcement learning.
- Adapting behavior through a reward-based policy trained in MATLAB.

## 🎯 Objectives

- Build a real-time embedded robotic system with line-following and obstacle detection capabilities.
- Apply **Reinforcement Learning** (Q-learning) to determine the best station wait times.
- Combine traditional sensor-actuator logic with adaptive learning for intelligent navigation.

## 🤖 Hardware Components

- **Microcontroller**: Arduino Uno (ATmega328P)
- **Chassis**: 2-Wheel Differential Drive + Caster
- **Sensors**:
  - IR Sensors (Line tracking)
  - Ultrasonic Sensors (Obstacle detection – Left & Right)
- **Actuators**:
  - 2× DC Motors (Driven by L298N Motor Driver)
  - Servo Motor (Sensor sweeping)
- **Power Supply**: 9V Battery Pack

## 🧠 Reinforcement Learning Integration

- **Learning Algorithm**: Q-learning
- **Training Platform**: MATLAB
- **States**: Station IDs (A, B, C, D)
- **Actions**: Wait times → {2s, 4s, 6s, 8s, 10s}
- **Rewards**: Probabilistic station-specific feedback
- **Output**: Learned Q-table policy mapping stations to optimal wait times

## 🛠️ Software Modules

### 🔄 1. Line Following
- IR sensor values drive motor control.
- Threshold-based tracking logic for path alignment.

### 🚧 2. Obstacle Detection and Avoidance
- Ultrasonic sensors on left/right detect nearby obstacles.
- Servo sweeps 180° to check direction.
- Robot chooses path with more clearance.

### ⏱️ 3. Station Timing with Q-Learning
- Offline Q-learning simulation in MATLAB.
- Trained policy determines real-time wait durations.

## 📈 Q-Learning MATLAB Simulation

```matlab
Q(s,a) = Q(s,a) + α [r - Q(s,a)]

