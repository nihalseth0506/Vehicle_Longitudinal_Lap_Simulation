# Vehicle Longitudinal Lap Simulation

A MATLAB & Simulink based longitudinal vehicle dynamics simulation with integrated brake control, automatic gearbox logic (Stateflow), aerodynamic drag modeling, and lap time evaluation.

This project simulates a vehicle completing a full lap on a parameterized track while respecting speed limits, gear shift logic, braking constraints, and powertrain torque characteristics.

---

## 🚗 Project Overview

The model simulates:

- Longitudinal vehicle dynamics
- Engine torque mapping
- Multi-gear automatic transmission (Stateflow-based)
- Aerodynamic drag
- Curvature-based speed limits
- Brake force control with stopping logic
- Lap timing & completion detection
- Data logging and post-processing
- 2D animated lap visualization (MP4 export)

The goal is to demonstrate structured system-level modeling using MATLAB and Simulink.

---

## 🧠 System Architecture

Main subsystems:

- **VehicleLongitudinalDynamics**
- **Powertrain**
- **GearboxLogic (Stateflow)**
- **BrakeController**
- **AeroDrag**
- **TrackAndSpeedLimit**
- **LapTimingAndLogging**

The model architecture is modular and parameter-driven.

---

## ⚙️ Powertrain & Gearbox

- 6-speed gearbox
- Configurable gear ratios
- Upshift & downshift thresholds
- Shift hysteresis
- Minimum shift time protection
- Torque curve interpolation
- Rev limiter logic
- Drivetrain efficiency modeling

Gear selection is implemented using a Stateflow state machine.

---

## 🛑 Brake Control

The braking model includes:

- Speed limit tracking
- Curvature-based velocity constraints
- Physics-based stopping distance logic
- Maximum brake force limitation
- Smooth deceleration before lap completion

---

## 🛣 Track Model

The track is parameterized using:

- Segment lengths
- Radius-based curvature definition
- Straight and curved sections
- Automatically generated centerline geometry

The curvature determines allowable vehicle speed.

---

## 📊 Outputs & Results

The simulation produces:

- Speed vs Distance
- Brake Force vs Distance
- Gear vs Distance
- Speed vs Time
- Distance vs Time
- Total Lap Time
- 2D animated lap visualization (MP4)

---

## 🎬 Animation

The vehicle motion is visualized on a 2D track map with:

- Color-coded speed
- Real-time gear display
- Braking indication
- MP4 export functionality

---

## 🗂 Project Structure

```
Vehicle_Longinal_Lap_Simulation/
│
├── vehicle/              # Main Simulink model (.slx)
├── parameters/           # Vehicle & powertrain parameter files
├── track/                # Track generation & geometry scripts
├── main/                 # Initialization scripts
├── analysis/             # Post-processing, plots & animation scripts
├── results/              # Generated figures & exported videos
├── mask_images/          # Custom subsystem mask icons
└── README.md             # Project documentation
```
---

## ▶️ How to Run

1. Open MATLAB
2. Run: init_simulation.m
3. Open vehicle_longitudinal.slx
4. Run simulation
5. For results: analyze_results.m
6. For animation: animate_lap.m

---

## 🛠 Tools Used

- MATLAB
- Simulink
- Stateflow
- VideoWriter (MP4 export)
- Modular parameter-based modeling

---

## 💡 Skills Demonstrated

- System-level vehicle dynamics modeling
- State machine-based gearbox implementation
- Control logic development
- Physics-based braking strategy design
- Simulation data logging & analysis
- Modular Simulink architecture structuring
- Visualization & animation generation
- Clean engineering project organization

---

## 🚀 Future Extensions

- Lateral vehicle dynamics modeling
- Tire slip & traction modeling
- Traction control system
- Engine throttle & driver model
- Energy consumption estimation
- Multi-lap race simulation
- Optimization-based lap time improvement

---

## 👤 Author

**Nihal Sanjay Seth**

MATLAB | Simulink | Vehicle Dynamics | Control Systems

---

