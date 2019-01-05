folder=fileparts(which(mfilename));
addpath(genpath(folder));
rmpath('.git');

% Set constants

% Half Car Info
a=1.25; % m - CoM to front point
b=1.4; % m - CoM to rear point
I=600; % Inertia of half car
mb=500; % kg - Mass of half car
m1=250; % kg - Mass per point


% Suspension
ks=2e4; % Suspension spring stiffness
ksHard=20*ks; % Hardened spring stiffness section
x0=0.2; % Spring Hardening distance

csExtend=1200; % dampener rate under extension
csCompress=600; % dampener rate under compression

% Wheel
m2=20; % kg - Wheel mass
kT=14e4; % Tyre stiffness
kTHard=1e10; % Wheel stiffness once tyre is fully compressed
                                     %(i.e. tyre bottoms out)
tyreLimit=1; % Tyre compression before tyre bottoms out to above stiffness

% Simulation
v_speed=10; % m/s - Vehicle Speed
stepValue=0.2; % m - Step value for step input road profile
g=9.81; % Acceleration due to gravity.

% Set initial conditions
frontHoldForce=mb*g*b/(a+b);
rearHoldForce=mb*g*a/(a+b);
frontWheelSettle=-(frontHoldForce+(m2*g))/kT;
rearWheelSettle=-(rearHoldForce+(m2*g))/kT;
frontBodySettle=-(frontHoldForce/ks)+frontWheelSettle;
rearBodySettle=-(rearHoldForce/ks)+rearWheelSettle;
bodySettle=frontBodySettle-((frontBodySettle-rearBodySettle)*(a/(a+b)));
pitchSettle=asin((frontBodySettle-rearBodySettle)/(a+b));

