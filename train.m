load('vibration_signals.mat');
num_signals = length(signals);

% 计算时频图
stft_features = cell(num_signals, 1);
window = hamming(256);
noverlap = 128;
nfft = 512;
fs = 1000;

for i = 1:num_signals
    [~,~,~,P] = spectrogram(signals{i}, window, noverlap, nfft, fs);
    stft_features{i} = 10*log10(abs(P));
end

% 构建CNN
layers = [
    imageInputLayer([size(stft_features{1}, 1) size(stft_features{1}, 2) 1], 'Name', 'input')
    convolution2dLayer(3, 8, 'Padding', 'same', 'Name', 'conv_1')
    batchNormalizationLayer('Name', 'bn_1')
    reluLayer('Name', 'relu_1')
    maxPooling2dLayer(2, 'Stride', 2, 'Name', 'maxpool_1')
    fullyConnectedLayer(3, 'Name', 'fc')
    softmaxLayer('Name', 'softmax')
    classificationLayer('Name', 'output')];

options = trainingOptions('sgdm', ...
    'MaxEpochs', 20, ...
    'MiniBatchSize', 16, ...
    'InitialLearnRate', 1e-3, ...
    'Shuffle', 'every-epoch', ...
    'Verbose', false, ...
    'Plots', 'training-progress');

% 训练CNN
stft_features = cat(4, stft_features{:});
Y = categorical(labels);
net = trainNetwork(stft_features, Y, layers, options);

fs = 1000;
test_signal = sin(2*pi*50*(0:1/fs:1-1/fs)); % 创建一个正弦波信号
plot_CAM(net, test_signal, fs);