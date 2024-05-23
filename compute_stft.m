% 计算信号的时频图
function [stft_feature] = compute_stft(signal, fs)
    window = hamming(256);
    noverlap = 128;
    nfft = 512;
    [~,~,~,P] = spectrogram(signal, window, noverlap, nfft, fs);
    stft_feature = 10*log10(abs(P));
end