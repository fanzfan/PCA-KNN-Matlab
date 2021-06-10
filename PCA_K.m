% 一维PCA实现，这里将MEL谱得到的9维数据压缩成1维返回
% inputArg1：待处理的信息
% num：信息条数，也是文件个数
% mu：阈值设定
function [outputArg1] = PCA_K(inputArg1, num, K)
    X = inputArg1;
    % 零均值化
    X_zeroMean = X - mean(X);
    % 协方差矩阵
    C = 1 / num * (X_zeroMean * X_zeroMean');
    % 求特征值与特征向量
    [V, D] = eig(C);
    [d, ind] = sort(diag(D), 'descend');
    % 按特征值大小排序
    Ds = D(ind, ind);
    Vs = V(:, ind);
    outputArg1 = Vs(:, 1:K)' * X;
end
