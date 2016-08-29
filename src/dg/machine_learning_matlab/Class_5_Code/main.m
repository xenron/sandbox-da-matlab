%% I. 清空环境变量
clear all
clc

%% II. 训练集/测试集产生
%%
% 1. 导入数据
load water_data.mat

%%
% 2. 数据归一化
attributes = mapminmax(attributes);

%%
% 3. 训练集和测试集划分

% 训练集——35个样本
P_train = attributes(:,1:35);
T_train = classes(:,1:35);
% 测试集——4个样本
P_test = attributes(:,36:end);
T_test = classes(:,36:end);

%% III. 竞争神经网络创建、训练及仿真测试
%%
% 1. 创建网络
net = newc(minmax(P_train),4,0.01,0.01);

%%
% 2. 设置训练参数
net.trainParam.epochs = 500;

%%
% 3. 训练网络
net = train(net,P_train);

%%
% 4. 仿真测试

% 训练集
t_sim_compet_1 = sim(net,P_train);
T_sim_compet_1 = vec2ind(t_sim_compet_1);
% 测试集
t_sim_compet_2 = sim(net,P_test);
T_sim_compet_2 = vec2ind(t_sim_compet_2);

%% IV. SOFM神经网络创建、训练及仿真测试
%%
% 1. 创建网络
net = newsom(P_train,[4 4]);

%%
% 2. 设置训练参数
net.trainParam.epochs = 200;

%%
% 3. 训练网络
net = train(net,P_train);

%%
% 4. 仿真测试

% 训练集
t_sim_sofm_1 = sim(net,P_train);
T_sim_sofm_1 = vec2ind(t_sim_sofm_1);
% 测试集
t_sim_sofm_2 = sim(net,P_test);
T_sim_sofm_2 = vec2ind(t_sim_sofm_2);

%% V. 结果对比
%%
% 1. 竞争神经网络
result_compet_1 = [T_train' T_sim_compet_1']
result_compet_2 = [T_test' T_sim_compet_2']

%%
% 2. SOFM神经网络
result_sofm_1 = [T_train' T_sim_sofm_1']
result_sofm_2 = [T_test' T_sim_sofm_2']
