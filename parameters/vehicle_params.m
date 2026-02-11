%% Vehicle Parameters
% All vehicle-related constants

veh.m   = 1500;        % Mass [kg]
veh.g   = 9.81;        % Gravity [m/s^2]

veh.wb  = 2.6;         % Wheelbase [m]
veh.lf  = 1.2;         % CG to front axle [m]
veh.lr  = veh.wb - veh.lf;

veh.hcg = 0.55;        % CG height [m]

%% Tire Parameters
tire.mu = 1.2;         % Friction coefficient

%% Aerodynamic Parameters
aero.rho = 1.225;      % Air density [kg/m^3]
aero.Cd  = 0.30;       % Drag coefficient
aero.A   = 2.2;        % Frontal area [m^2]

%% Brake Parameters
brake.maxForce = 16000; % Max total braking force [N]

%% Track Parameters
track.stopZoneLength = 1000;   % meters before finish
%% Powertrain Parameters

pt.r_w = 0.33;                 % wheel radius [m]
pt.finalDrive = 3.5;
pt.efficiency = 0.95;

pt.gearRatios = [3.8 2.3 1.6 1.2 1.0 0.85];

pt.rpm_idle = 1000;
pt.rpm_max  = 8000;

% Simple torque curve
pt.rpm_map = [1000 2000 3000 4000 5000 6000 7000 8000];
pt.torque_map = [180 220 250 270 280 260 220 150];  % Nm

pt.upshiftRPM = 6500;
pt.downshiftRPM = 3000;
pt.minShiftTime = 0.2; %seconds

upshiftRPM   = pt.upshiftRPM;
downshiftRPM = pt.downshiftRPM;
minShiftTime = pt.minShiftTime; %seconds