%% 训练程序
%% 为了方便处理，做fft将数据化为等长形式
mu = 0.5 : 0.05 : 0.9;
numOfVec = zeros(1, length(mu));

%% 初始化
num = 128;
fftPoints = 2048;
voice_fft = zeros(fftPoints, num);
% 读取源数据并作fft
for j = 1 : num
    voice_fft(:, j) = fft(audioread(['.\数据\训练样本\' num2str(j) '.wav']), fftPoints);
end

%% PCA计算
for i = 1 : length(mu)
    voice_PCA = PCA(abs(voice_fft), num, mu(i));
    % 存储训练集
    save(['.\PCA结果暂存\voice_PCA_' num2str(mu(i)) '.csv'],'voice_PCA', '-ascii');
    [numOfVec(i), ~] = size(voice_PCA);
end

%% 绘图
plot(mu, numOfVec, 'Color','#A2142F','LineWidth', 2);title('PCA特征向量与阈值的关系')
axis([0.4 1 0 10])
ylabel('特征向量个数')
xlabel('PCA阈值 \mu')
figure(2)
stem(1:128 , sum(abs(voice_PCA)),'LineWidth', 2);title('阈值\mu为0.9时，PCA得到的数据模值分布情况')
hold on
stem(71:110 , sum(abs(voice_PCA(:,71:110))),'LineWidth', 2)
ylabel('向量模值')
xlabel('训练样本编号')
legend('正常样本', '故障样本')