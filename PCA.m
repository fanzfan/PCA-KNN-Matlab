% 一维PCA实现
% X：待处理的信息
% num：信息条数，也是文件个数
% mu：阈值设定
function [outputArg1] = PCA(X, num, mu)
    % 零均值化
    X_zeroMean = X - mean(X);
    % 协方差矩阵
    C = 1 / num * (X_zeroMean * X_zeroMean');
    % 求特征值与特征向量
    [V, D] = eig(C);
    [d, ind] = sort(diag(D), 'descend');
    % 按特征值大小排序
    Vs = V(:, ind);
    % 根据阈值选择 降低的维数
    for k = 1:length(d)
        if (sum(d(1:k)) / sum(d) >= mu)
            break;
        end
    end
    outputArg1 = Vs(:, 1:k)' * X;
end
