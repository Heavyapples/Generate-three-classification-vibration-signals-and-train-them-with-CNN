% 计算类激活映射（CAM）热图
function [heatmap] = compute_CAM(net, stft_feature)
    act_layer = 'relu_1';
    conv_activations = activations(net, stft_feature, act_layer, 'OutputAs', 'columns');
    conv_activations = reshape(conv_activations, [size(stft_feature, 1), size(stft_feature, 2), 8]);

    softmax_weights = net.Layers(end-2).Weights; 
    [~,class_idx] = max(predict(net, stft_feature));

    cam = zeros(size(stft_feature, 1), size(stft_feature, 2));
    for i = 1:size(softmax_weights, 1)
        cam = cam + softmax_weights(i, class_idx) * conv_activations(:,:,i);
    end

    heatmap = cam;
    heatmap = imresize(heatmap, size(stft_feature));
    heatmap = heatmap ./ max(heatmap(:));
end