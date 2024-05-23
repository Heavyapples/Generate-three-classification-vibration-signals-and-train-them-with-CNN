% 生成信号
fs = 1000;
t = 0:1/fs:1-1/fs;
num_signals = 100;

sin_wave = sin(2*pi*50*t);
square_wave = square(2*pi*50*t);
sawtooth_wave = sawtooth(2*pi*50*t);

signals = cell(num_signals, 1);
labels = zeros(num_signals, 1);

% 创建数据集
for i = 1:num_signals
    switch mod(i,3)
        case 0
            signals{i} = sin_wave;
            labels(i) = 1;
        case 1
            signals{i} = square_wave;
            labels(i) = 2;
        case 2
            signals{i} = sawtooth_wave;
            labels(i) = 3;
    end
end

% 保存数据集
save('vibration_signals.mat', 'signals', 'labels');
