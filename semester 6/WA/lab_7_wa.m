
lambda = input('Enter the wavelength (in meters): ');

% Distance between elements
d = lambda;

% Number of elements
N = 2;

% Wavenumber
k = 2*pi / lambda;

% Relative phase difference
alpha = -(k*d);

% Angle range (0 to pi)
theta = linspace(0, 2*pi, 1000);

% Array factor calculation using the given formula
Io = 1; % Assuming a unit current
AF = 2 * Io * cos(alpha/2 + (k*d*cos(theta))/2);

% Display the calculated array factor in the terminal
%disp('Array Factor (AF):');
%disp('2*I*cos(pi*cos(theta)');

% Plot the array factor in polar coordinates
polarplot(theta, (AF));

% Finding maxima and nulls
[maxima, maxima_indices] = findpeaks(AF);
[nulls, nulls_indices] = findpeaks(-AF);
nulls = -nulls;

