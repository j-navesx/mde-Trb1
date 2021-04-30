close all
load y210420_150548.dat
x = y210420_150548;
clear y210420_150548;

% t - time
t = x(:,1);

% y - output : distance [m]
y = x(:,2);

% v - output : vehicle speed [m/s]
v = x(:,3);

% u - control input : throttle [0-1]
u = x(:,4);

% yr - reference : reference distance [m]
yr = x(:,5);

% vf - disturbance : foregoing speed [m/s]
vf = x(:,6);

% w - disturbance : wind speed [m/s]
w = x(:,7);

% theta - disturbance : slope [rad]
th = x(:,8);

% kpiOutput - performance index Output
kpiOutput = x(:,9);

% kpiInput - performance index Input
kpiInput = x(:,10);

% kpiTotal - performance index Total
kpiTotal = x(:,11);

clear x;

figure('Name','Distance');
plot(t, [y yr]); title('Distance [m]'); ylabel('y, yr [m]'); xlabel('t [s]');

figure('Name','Speeds');
plot(t, [v vf]); title('Speeds [m/s]'); ylabel('v, vf [m/s]'); xlabel('t [s]');

figure('Name','Wind speed');
plot(t, w); title('Wind speed [m/s]'); ylabel('w [m/s]'); xlabel('t [s]');

figure('Name','Road slope');
plot(t, th*100.0); title('Slope [%]'); ylabel('th [%]'); xlabel('t [s]');

figure('Name','Control action');
plot(t, u*100.0); title('Throttle [%]'); ylabel('u [%]'); xlabel('t [s]');

figure('Name','Performance Index');
plot(t, [kpiOutput kpiInput kpiTotal]); title('KPIs'); ylabel('kpi'); xlabel('t [s]');

