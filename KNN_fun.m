%% KNN_FUN KNN算法匹配样本与训练
% data：输入数据
% K：指定KNN系数
% result:样本匹配结果
function [result] = KNN_fun(data, K, mu)
    %% 加载训练集
    P = load(['.\PCA结果暂存\voice_PCA_' num2str(mu) '.csv']);
    % 已知的数据分布情况
    distribution = [ones(1, 16) 2 * ones(1, 15) 3 * ones(1, 15) 4 * ones(1, 24) 5 * ones(1, 12) 6 * ones(1, 28) 7 * ones(1, 18)];
    % 范数计算
    Distance = sum(abs(P - data).^2, 1);
    % 排序，找到最小距离并输出
    [~, ind] = sort(Distance);
    K = K - 1 + mod(K, 2);
    temp = tabulate(distribution(ind(1:K)));
    [~, I] = max(temp(:, 3));
    result = temp(I, 1);
end
