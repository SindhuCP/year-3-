clc;
clear;

%% Generate QPSK Modulated Data
N = 10000; % Number of QPSK symbols
x = randi([0 1], 1, 2*N); % Random bit generation

% QPSK Modulation
xmod = ((1-2*x(1:2:end)) + 1j * (1-2*x(2:2:end))) / sqrt(2);

% Define SNR range from 0 to 40 dB
snrdb_range = 0:1:40;
ber = zeros(size(snrdb_range)); % Initialize BER array

for idx = 1:length(snrdb_range)
    snrdb = snrdb_range(idx);
    snrlin = db2pow(snrdb);
    
    % Additive White Gaussian Noise (AWGN)
    noise = (randn(1, N) + 1j * randn(1, N)) / sqrt(2);
    
    % Received signal
    yrx = xmod + sqrt(1/snrlin) * noise;
    
    % QPSK Demodulation
    ydemod = zeros(1, 2*N);
    ydemod(1:2:end) = real(yrx) < 0; % In-phase component
    ydemod(2:2:end) = imag(yrx) < 0; % Quadrature component
    
    % BER Calculation
    BERcount = sum(xor(ydemod, x));
    ber(idx) = BERcount / N;
end

% Plot BER vs SNR for QPSK Modulation
figure;
semilogy(snrdb_range, ber, '-o', 'LineWidth', 2);
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs SNR for QPSK Modulation');

%% CNN for QPSK Demodulation

% Data preparation
xmod_real = real(xmod);
xmod_imag = imag(xmod);
xmod_noisy_real = real(yrx);
xmod_noisy_imag = imag(yrx);

% Reshape data for CNN input
input_data = cat(3, xmod_noisy_real, xmod_noisy_imag); % Concatenate real and imaginary parts
input_data = permute(input_data, [3 1 2]); % Permute dimensions for CNN input

output_data = cat(3, xmod_real, xmod_imag); % Concatenate real and imaginary parts for output
output_data = permute(output_data, [3 1 2]); % Permute dimensions for CNN output

% Define CNN architecture
layers = [
    imageInputLayer([2 N])   % Input layer for real and imaginary parts
    convolution2dLayer(3, 16, 'Padding', 'same')  % Convolution layer with 16 filters
    reluLayer   % ReLU activation layer
    convolution2dLayer(3, 32, 'Padding', 'same')  % Convolution layer with 32 filters
    reluLayer   % ReLU activation layer
    convolution2dLayer(3, 2, 'Padding', 'same')   % Convolution layer with 2 filters (real and imaginary output)
    ];

lgraph = layerGraph(layers);

% Training options
options = trainingOptions('adam', ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 64, ...
    'Shuffle', 'every-epoch', ...
    'Plots', 'training-progress');

% Convert data to table
input_data_tbl = array2table(input_data);
output_data_tbl = array2table(output_data);

% Train the CNN
net = trainNetwork(input_data_tbl, output_data_tbl, lgraph, options);

% Test the CNN
ypred = predict(net, input_data_tbl);

% Calculate BER for predicted symbols
ypred_real = squeeze(ypred(:, 1, :));
ypred_imag = squeeze(ypred(:, 2, :));

ypred_demod = zeros(1, 2*N);
ypred_demod(1:2:end) = ypred_real < 0; % In-phase component
ypred_demod(2:2:end) = ypred_imag < 0; % Quadrature component

BERcount_cnn = sum(xor(ypred_demod, x));
ber_cnn = BERcount_cnn / N;

fprintf('BER using CNN: %.6f\n', ber_cnn);
