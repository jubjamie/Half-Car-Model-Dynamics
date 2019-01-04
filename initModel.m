folder=fileparts(which(mfilename));
addpath(genpath(folder));
rmpath('.git');

% Set constants

% Quater Car Info
m1=250; % kg - Mass per point


% Suspension
ks=2e4; % Suspension spring stiffness

cs=1000; % dampener rate under extension
% dampener rate under compression

% Wheel
m2=20; % kg - Wheel mass
kT=14e4; % Tyre stiffness

% Simulation
g=9.81; % Acceleration due to gravity.

