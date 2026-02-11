clc;
clear;
close all;

addpath(genpath(pwd));

% Load vehicle parameters
run('parameters/vehicle_params.m');

% Load track
run('track/track_definition.m'); 

disp('Simulation initialized successfully.');