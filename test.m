%% 测试样本程序
% 训练集已经通过训练程序产生
% 为了方便处理，做fft将数据化为等长形式

%% 初始化
mu = 0.5 : 0.05 : 0.9;
num = 58;
fftPoints = 2048;

% 指定PCA维度，使其与训练集匹配
n = zeros(1,length(mu));
errNum = n;
voice_fft = zeros(fftPoints, num);
typ = zeros(1, num);
% KNN系数
K = 3;

%% 加载测试样本
% 读取并作fft
for i = 1 : num
    voice_fft(:, i) = fft(audioread(['.\数据\测试样本\' num2str(i) '.wav']), fftPoints);
end

%% PCA与KNN算法
for i = 1 : length(mu)
    [n(i), ~] = size(load(['.\PCA结果暂存\voice_PCA_' num2str(mu(i)) '.csv']));
    test_PCA = PCA_K(abs(voice_fft), num, n(i));
    for j = 1 : num
        typ(j) = KNN_fun(test_PCA(:,j), K, mu(i));
    end
    errNum(i) = length([find(typ(1:35)==5) find(typ(1:35)==6) find(typ(36:48)~=5&typ(36:48)~=6) find(typ(49:58)==5) find(typ(49:58)==6)]);
    %% 预测错误率
    disp(['K = ' num2str(K) '，mu = ' num2str(mu(i)) ' 情况下的预测错误率：' num2str(errNum(i) / num * 100) '%']);
end

plot(mu, errNum/num * 100,'Color', '#77AC30', 'LineWidth', 2);title('模型预测错误率')
hold on
ylabel('错误率 %')
xlabel('PCA阈值 \mu')
axis([0.4 1 0 20])
legend('KNN-PCA 模型预测错误率')


