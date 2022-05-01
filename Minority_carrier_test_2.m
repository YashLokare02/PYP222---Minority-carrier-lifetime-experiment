% Minority carrier experiment 

% Importing data into MATLAB
Temperature_data = xlsread('Temperature_data.xlsx');

% Parameters
n = 20; % no of columns
rows = 2500; % no of rows
idx = 437; % relevant ending index of unwanted data
conversion_factor = 273;
temps = [40, 50, 60, 70, 80, 90, 100, 110, 120, 130] + conversion_factor; % temperature values in [K]
e = 1.602*1e-19; % electronic charge
kB = 1.38*1e-23; % Boltzmann's constant

% Extracting relevant linear regions
val = (rows/2 - (idx + 1) + 1) - 100;
relevant_data = zeros(val, n);

for i = 1:n
    relevant_data(:, i) = Temperature_data(idx+1:(rows/2 - 100), i);
end

% Extracting time data
time_data = relevant_data(:, 1:2:n-1);

% Extracting voltage (y-axis) data
volt_data = relevant_data(:, 2:2:n);

% Linear fitting to extract the slope of the data
carrier_lifetimes = zeros(1, n/2);
parameters = zeros(2, n/2); % fitting parameters for each dataset

% Numerical computation
for i = 1:(n/2 - 3) % for the first seven datasets
    [carrier_lifetime, para_vals] = linear_fit(time_data(:, i), volt_data(:, i), -0.0461, 0.4354*1e-6, temps(i), e, kB);
    carrier_lifetimes(i) = carrier_lifetime;
    parameters(:, i) = para_vals;
end

% For the next 3 datasets
time_data_new = time_data(301:end, 8:1:10);
volt_data_new = volt_data(301:end, 8:1:10);

% Numerical computation
for i = (n/2 - 2):1:n/2 % for the last 3 datasets
    [carrier_lifetime, para_vals] = linear_fit(time_data_new(:, i-7), volt_data_new(:, i-7), -0.0461, 0.4354*1e-6, temps(i), e, kB);
    carrier_lifetimes(i) = carrier_lifetime;
    parameters(:, i) = para_vals;
end

% Visualization
% figure(1); % for T = 40 degrees 
% plot(Temperature_data(:, 1), Temperature_data(:, 2), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(2); % for T = 50 degrees 
% plot(Temperature_data(:, 3), Temperature_data(:, 4), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(3); % for T = 60 degrees 
% plot(Temperature_data(:, 5), Temperature_data(:, 6), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(4); % for T = 70 degrees 
% plot(Temperature_data(:, 7), Temperature_data(:, 8), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(5); % for T = 80 degrees 
% plot(Temperature_data(:, 9), Temperature_data(:, 10), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(6); % for T = 90 degrees 
% plot(Temperature_data(:, 11), Temperature_data(:, 12), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(7); % for T = 100 degrees 
% plot(Temperature_data(:, 13), Temperature_data(:, 14), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(8); % for T = 110 degrees 
% plot(Temperature_data(:, 15), Temperature_data(:, 16), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(9); % for T = 120 degrees 
% plot(Temperature_data(:, 17), Temperature_data(:, 18), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(10); % for T = 130 degrees 
% plot(Temperature_data(:, 19), Temperature_data(:, 20), 'k', 'LineWidth', 2);
% grid
% xlabel('Time [s]', 'FontSize', 20);
% ylabel('Voltage [V]', 'FontSize', 20);
% 
% figure(11); % carrier lifetime vs. temperature
% plot(temps, carrier_lifetimes, 'k', 'LineWidth', 2);
% grid
% xlabel('Temperature [K]', 'FontSize', 20);
% ylabel('$\tau$ [s]', 'Interpreter', 'latex', 'FontSize', 20);

% To investigate the dependence of \tau on temperature
% Initial guesses
beta0 = [8.53e-9; 3/2; -2.372e-6; 2.61e-4]; % initial guesses for the parametric fit

% Defining the model
f = @(b, temps) b(1).*(temps.^b(2)) + b(3).*temps + b(4); % model fit

% Parametric fitting using fminsearch
para_vals = fminsearch(@(b) norm(carrier_lifetimes - f(b, temps)), beta0); % Estimating fitting parameters

% Visualization
yfit = f(para_vals, temps);

figure(12);
plot(temps, carrier_lifetimes, 'ko');
hold on
plot(temps, yfit, 'r', 'LineWidth', 2);
grid
xlabel('Temperature [K]', 'FontSize', 20);
ylabel('$\tau$ [s]', 'Interpreter', 'latex', 'FontSize', 20);
legend('Experimental data', 'Power-law fit', 'FontSize', 19, 'Orientation', 'vertical', 'Location', 'best');















