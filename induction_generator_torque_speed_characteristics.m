% For an induction generator with given synchronous speed

% The input values taken for the plot are as follows, they can be adjusted
% as per the user
r1 = 0.6;                 % Stator resistance
x1 = 1.0;                 % Stator reactance
r2 = 0.3;                 % Rotor resistance
x2 = 0.4;                 % Rotor reactance
xm = 27;                  % Magnetization branch reactance
v_phase = 500 / sqrt(3);    % Phase voltage taking input voltage as 500
n_sync = 1800;              % Synchronous speed (r/min)
w_sync = 188.5;             % Synchronous speed (rad/s)

% Calculation of the Thevenin Voltage and Impedance 
v_th = v_phase * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
z_th = ((j*xm) * (r1 + j*x1)) / (r1 + j*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);

% Calculation of torque-speed characteristic for many
% slips between 0 and 1.
s = (0:1:50) / 50;           % Slip
s(1) = 0.001;
nm = (1 + s) * n_sync;       % Mechanical speed

% Calculate torque for rotor resistance
for ii = 1:51
   t_ind1(ii) = (-1)*(3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
end

% Plot the torque-speed curve
plot(nm,t_ind1,'Color','k','LineWidth',2.0);
hold on;
xlabel('\itn_{m}','FontSize',12);
ylabel('\tau_{ind}','FontSize',12);
title ('Induction generator torque-speed characteristic','FontSize',12);
grid on;
hold off;