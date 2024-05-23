% 绘制时频图和热图
function plot_CAM(net, signal, fs)
    stft_feature = compute_stft(signal, fs);
    heatmap = compute_CAM(net, stft_feature);

    figure;
    subplot(2, 1, 1);
    imagesc(stft_feature);
    title('Time-Frequency Representation');
    xlabel('Time');
    ylabel('Frequency');
    colorbar;

    subplot(2, 1, 2);
    imagesc(heatmap);
    title('Class Activation Mapping (CAM)');
    xlabel('Time');
    ylabel('Frequency');
    colormap('jet');
    colorbar;
end