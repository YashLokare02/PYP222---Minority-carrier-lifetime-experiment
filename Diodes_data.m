% Minority carrier experiment 

% Importing data into MATLAB
diodes_data = xlsread('Diodes_data.xlsx');

% Parameters
n = 6; % no of columns
rows = 2500; % no of rows
idx = 437; % relevant ending index of unwanted data
e = 1.602*1e-19; % electronic charge
kB = 1.38*1e-23; % Boltzmann's constant
T = 303; % temperature in [K]

% Extracting relevant linear regions
val = (rows/2 - (idx + 1) + 1) - 100;
relevant_data = zeros(val, n);

for i = 1:n
    relevant_data(:, i) = diodes_data(idx+1:(rows/2 - 100), i);
end

% Extracting time data
time_data = relevant_data(:, 1:2:n-1);

% Extracting voltage (y-axis) data
volt_data = relevant_data(:, 2:2:n);

% Removing unwanted data for datasets 2 and 3
time_data_3 = time_data(561:end, 3); % for dataset 3
volt_data_3 = volt_data(561:end, 3);

time_data_2 = time_data(641:end, 2); % for dataset 2
volt_data_2 = volt_data(641:end, 2);

% Storing parameter values
parameters = zeros(2, n/2);

% Carrier lifetimes
carrier_lifetimes = zeros(1, n/2);

% Numerical computation
[carrier_lifetime, para_vals] = linear_fit(time_data(:, 1), volt_data(:, 1), -0.042, 0.62*1e-6, T, e, kB);
carrier_lifetimes(1) = carrier_lifetime; % for dataset 1
parameters(:, 1) = para_vals;

[carrier_lifetime, para_vals] = linear_fit(time_data_2, volt_data_2, -0.042, 0.62*1e-6, T, e, kB);
carrier_lifetimes(2) = carrier_lifetime; % for dataset 2
parameters(:, 2) = para_vals;

[carrier_lifetime, para_vals] = linear_fit(time_data_3, volt_data_3, -0.042, 0.62*1e-6, T, e, kB);
carrier_lifetimes(3) = carrier_lifetime; % for dataset 3
parameters(:, 3) = para_vals;

% Visualization
figure(1); % for dataset 1
plot(diodes_data(:, 1), diodes_data(:, 2), 'k', 'LineWidth', 2);
grid
xlabel('Time [s]', 'FontSize', 20);
ylabel('Voltage [V]', 'FontSize', 20);

figure(2); % for dataset 2
plot(diodes_data(:, 3), diodes_data(:, 4), 'k', 'LineWidth', 2);
grid
xlabel('Time [s]', 'FontSize', 20);
ylabel('Voltage [V]', 'FontSize', 20);

figure(3); % for dataset 3
plot(diodes_data(:, 5), diodes_data(:, 6), 'k', 'LineWidth', 2);
grid
xlabel('Time [s]', 'FontSize', 20);
ylabel('Voltage [V]', 'FontSize', 20);






