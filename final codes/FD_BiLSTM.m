clc;
clear;
close all;

% load both normal(O) and pathological(S) subjects
files = dir('*.mat');
for i=1:length(files)
    load(files(i).name);
end

% % normal signals eye closed(B) 
O=[O001,O002,O003,O004,O005,O006,O007,O008,O009,O010,O011,O012,O013,O014,O015,O016,O017,O018,O019,O020,...
  O021,O022,O023,O024,O025,O026,O027,O028,O029,O030,O031,O032,O033,O034,O035,O036,O037,O038,O039,O040,...
  O041,O042,O043,O044,O045,O046,O047,O048,O049,O050,O051,O052,O053,O054,O055,O056,O057,O058,O059,O060,...
  O061,O062,O063,O064,O065,O066,O067,O068,O069,O070,O071,O072,O073,O074,O075,O076,O077,O078,O079,O080,...
  O081,O082,O083,O084,O085,O086,O087,O088,O089,O090,O091,O092,O093,O094,O095,O096,O097,O098,O099,O100];

% % normal signals eye opened(A)
Z=[Z001,Z002,Z003,Z004,Z005,Z006,Z007,Z008,Z009,Z010,Z011,Z012,Z013,Z014,Z015,Z016,Z017,Z018,Z019,Z020,...
  Z021,Z022,Z023,Z024,Z025,Z026,Z027,Z028,Z029,Z030,Z031,Z032,Z033,Z034,Z035,Z036,Z037,Z038,Z039,Z040,...
  Z041,Z042,Z043,Z044,Z045,Z046,Z047,Z048,Z049,Z050,Z051,Z052,Z053,Z054,Z055,Z056,Z057,Z058,Z059,Z060,...
  Z061,Z062,Z063,Z064,Z065,Z066,Z067,Z068,Z069,Z070,Z071,Z072,Z073,Z074,Z075,Z076,Z077,Z078,Z079,Z080,...
  Z081,Z082,Z083,Z084,Z085,Z086,Z087,Z088,Z089,Z090,Z091,Z092,Z093,Z094,Z095,Z096,Z097,Z098,Z099,Z100];

% % interictal signals (C)
F=[F001,F002,F003,F004,F005,F006,F007,F008,F009,F010,F011,F012,F013,F014,F015,F016,F017,F018,F019,F020,...
  F021,F022,F023,F024,F025,F026,F027,F028,F029,F030,F031,F032,F033,F034,F035,F036,F037,F038,F039,F040,...
  F041,F042,F043,F044,F045,F046,F047,F048,F049,F050,F051,F052,F053,F054,F055,F056,F057,F058,F059,F060,...
  F061,F062,F063,F064,F065,F066,F067,F068,F069,F070,F071,F072,F073,F074,F075,F076,F077,F078,F079,F080,...
  F081,F082,F083,F084,F085,F086,F087,F088,F089,F090,F091,F092,F093,F094,F095,F096,F097,F098,F099,F100];
% % interictal signals (D)
N=[N001,N002,N003,N004,N005,N006,N007,N008,N009,N010,N011,N012,N013,N014,N015,N016,N017,N018,N019,N020,...
  N021,N022,N023,N024,N025,N026,N027,N028,N029,N030,N031,N032,N033,N034,N035,N036,N037,N038,N039,N040,...
  N041,N042,N043,N044,N045,N046,N047,N048,N049,N050,N051,N052,N053,N054,N055,N056,N057,N058,N059,N060,...
  N061,N062,N063,N064,N065,N066,N067,N068,N069,N070,N071,N072,N073,N074,N075,N076,N077,N078,N079,N080,...
  N081,N082,N083,N084,N085,N086,N087,N088,N089,N090,N091,N092,N093,N094,N095,N096,N097,N098,N099,N100];

% % ictal signals(E)
S=[S001,S002,S003,S004,S005,S006,S007,S008,S009,S010,S011,S012,S013,S014,S015,S016,S017,S018,S019,S020,...
  S021,S022,S023,S024,S025,S026,S027,S028,S029,S030,S031,S032,S033,S034,S035,S036,S037,S038,S039,S040,...
  S041,S042,S043,S044,S045,S046,S047,S048,S049,S050,S051,S052,S053,S054,S055,S056,S057,S058,S059,S060,...
  S061,S062,S063,S064,S065,S066,S067,S068,S069,S070,S071,S072,S073,S074,S075,S076,S077,S078,S079,S080,...
  S081,S082,S083,S084,S085,S086,S087,S088,S089,S090,S091,S092,S093,S094,S095,S096,S097,S098,S099,S100];
% %--------------------------------------------------------------------------------------------------------------------------------------%
z1=signalFrequencyFeatureExtractor("SampleRate",256,"MedianFrequency",true,"MeanFrequency",true,"BandPower",true,"PowerBandwidth",true);

features1=extract(z1,Z);
features2=extract(z1,O);
features3=extract(z1,F);
features4=extract(z1,N);
features5=extract(z1,S);

for i=1:100
    KNN1(i,:)=features1(:,:,i);
    KNN2(i,:)=features2(:,:,i);
    KNN3(i,:)=features3(:,:,i);
    KNN4(i,:)=features4(:,:,i);
    KPP1(i,:)=features5(:,:,i);
end

KN1=KNN1'; % A
KN2=KNN2'; % B
KN3=KNN3'; % C
KN4=KNN4'; % D
KP1=KPP1'; % E

clear features1 features2 features3 features4 features5 KNN1 KNN2 KNN3 KNN4 KPP1
L=4;
% %--------------------------------------------------------------------------------------------------------------------------------------%
% % Define training and testing sets
T1=[ones(80,1);zeros(80,1)];
Ttrain=categorical(T1);

rowdist1=[1 ones(1,159)];
rowdist2=[1 ones(1,39)];

T1=[ones(20,1);zeros(20,1)];
Tvalidate=categorical(T1);
% %--------------------------------------------------------------------------------------------------------------------------------------%
% % 1.Classification between Normal(A) and seizure(E) 
% % % Training data
X1=[KN1(:,1:80),KP1(:,1:80)];
X2=reshape(X1',160,L);
Xtrain = mat2cell(X2,rowdist1);

% % Validation data
X1=[KN1(:,81:100),KP1(:,81:100)];                 
X2=reshape(X1',40,L);
Xvalidate = mat2cell(X2,rowdist2);

% % Classification using BiLSTM networks
inputSize = 1;
numHiddenUnits = 100;
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 200;
miniBatchSize = 25;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',1, ...
    'Verbose',false, ...
    'Plots','training-progress');

net1 = trainNetwork(Xtrain,Ttrain,layers,options);

% % Testing data
XTest = Xvalidate;
YTest = Tvalidate;
YPred = classify(net1,XTest,'MiniBatchSize',miniBatchSize);
acc1 = sum(YPred == YTest)./numel(YTest);
figure;plotconfusion(YTest,YPred);
title(' Confusion Matrix A - E ')
fprintf('Accuracy of prediction %f\n',100*acc1);
% % % ---------------------------------------------------------------------------------------------------------------------------------------%
% % 2.Classification between Normal(B) and seizure(E) 
% % Training data
% X1=[KN2(:,1:80),KP1(:,1:80)];
% X2=reshape(X1',160,L);
% Xtrain = mat2cell(X2,rowdist1);
% 
% % % Validation data
% X1=[KN2(:,81:100),KP1(:,81:100)];                 
% X2=reshape(X1',40,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 2;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net1 = trainNetwork(Xtrain,Ttrain,layers,options);
% 
% % % Testing data
% XTest = Xvalidate;
% YTest = Tvalidate;
% YPred2 = classify(net1,XTest,'MiniBatchSize',miniBatchSize);
% acc2 = sum(YPred2 == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred2);
% title(' Confusion Matrix B - E ')
% fprintf('Accuracy of prediction %f\n',100*acc2);
% % % ---------------------------------------------------------------------------------------------------------------------------------------%
% % 3. Classification between interictal(C) and ictal(E) 
% % Training data
% X1=[KN3(:,1:80),KP1(:,1:80)];
% X2=reshape(X1',160,L);
% Xtrain = mat2cell(X2,rowdist1);
% 
% % % Validation data
% X1=[KN3(:,81:100),KP1(:,81:100)];                 
% X2=reshape(X1',40,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 2;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net1 = trainNetwork(Xtrain,Ttrain,layers,options);
% 
% % % Testing data
% XTest = Xvalidate;
% YTest = Tvalidate;
% YPred3 = classify(net1,XTest,'MiniBatchSize',miniBatchSize);
% acc3 = sum(YPred3 == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred3);
% title(' Confusion Matrix C - E ')
% fprintf('Accuracy of prediction %f\n',100*acc3);
% % % [TPR3,TNR3,Acc3,BA3,PPV3,NPV3,F13,MCCS3] = myperf(Tvalidate,YPred3);
% % % ---------------------------------------------------------------------------------------------------------------------------------------%
% % 4. Classification between interictal(D) and ictal(E) 
% % % Training data
% X1=[KN4(:,1:80),KP1(:,1:80)];
% X2=reshape(X1',160,L);
% Xtrain = mat2cell(X2,rowdist1);
% 
% % % Validation data
% X1=[KN4(:,81:100),KP1(:,81:100)];                 
% X2=reshape(X1',40,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 2;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net1 = trainNetwork(Xtrain,Ttrain,layers,options);
% 
% % % Testing data
% XTest = Xvalidate;
% YTest = Tvalidate;
% YPred4 = classify(net1,XTest,'MiniBatchSize',miniBatchSize);
% acc4 = sum(YPred4 == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred4);
% title(' Confusion Matrix D - E ')
% fprintf('Accuracy of prediction %f\n',100*acc4);
% % % % [TPR4,TNR4,Acc4,BA4,PPV4,NPV4,F14,MCCS4] = myperf(Tvalidate,YPred4);
% % % % ---------------------------------------------------------------------------------------------------------------------------------------%
% % % % 5. Classification between seizure(E) and non seizure(ABCD) 
% rowdist1=[1 ones(1,399)];
% rowdist2=[1 ones(1,99)];
% % Define training sets
% T1=[ones(320,1);zeros(80,1)];
% Ttrain=categorical(T1);
% % Define testing sets
% T2=[ones(80,1);zeros(20,1)];
% Tvalidate=categorical(T2);
% 
% X1=[KN1(:,1:80),KN2(:,1:80),KN3(:,1:80),KN4(:,1:80),KP1(:,1:80)];
% X2=reshape(X1',400,L);
% Xtrain = mat2cell(X2,rowdist1);
% X1=[KN1(:,81:100),KN2(:,81:100),KN3(:,81:100),KN4(:,81:100),KP1(:,81:100)];
% X2=reshape(X1',100,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 2;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net = trainNetwork(Xtrain,Ttrain,layers,options);
% 
% % Testing data
% XTest = Xvalidate ;
% YTest = Tvalidate;
% YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);
% acc5 = sum(YPred == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred);
% title(' Confusion Matrix ABCD - E ')
% fprintf("\n Accuracy of classification between normal(ABCD) and ictal(E)= %f \n",100*acc5);
% % % % % [TPR4,TNR4,Acc4,BA4,PPV4,NPV4,F14,MCCS4] = myperf(Tvalidate,YPred4);
% % % % ---------------------------------------------------------------------------------------------------------------------------------------%
% % % 6. Classification between seizure(E) and non seizure(AB) 
% L=8;
% Z1=[KN1;KN2];
% S1=[KP1;KP1];
% 
% % % Training data
% X1=[Z1(:,1:80),S1(:,1:80)];
% X2=reshape(X1',160,L);
% Xtrain = mat2cell(X2,rowdist1);
% X1=[Z1(:,81:100),S1(:,81:100)];                 
% X2=reshape(X1',40,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 2;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net = trainNetwork(Xtrain,Ttrain,layers,options);
% 
% % % Testing data
% XTest = Xvalidate ;
% YTest = Tvalidate;
% YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);
% acc = sum(YPred == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred);
% title(' Confusion Matrix AB - E ')
% fprintf("\n Accuracy of classification between normal(AB) and ictal(E)= %f \n",100*acc);
% % % % [TPR4,TNR4,Acc4,BA4,PPV4,NPV4,F14,MCCS4] = myperf(Tvalidate,YPred4);
% % % % ---------------------------------------------------------------------------------------------------------------------------------------%
% % % % 7. Classification between seizure(E) and Inter-ictal(CD) 
% L=8;
% Z1=[KN3;KN4];
% S1=[KP1;KP1];
% 
% X1=[Z1(:,1:80),S1(:,1:80)];
% X2=reshape(X1',160,L);
% Xtrain = mat2cell(X2,rowdist1);
% X1=[Z1(:,81:100),S1(:,81:100)];                 
% X2=reshape(X1',40,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 2;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net = trainNetwork(Xtrain,Ttrain,layers,options);
% % Testing data
% XTest = Xvalidate ;
% YTest = Tvalidate;
% YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);
% acc = sum(YPred == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred);
% title(' Confusion Matrix CD - E ')
% fprintf("\n Accuracy of classification between inter-ictal(CD) and ictal(E)= %f \n",100*acc);
% % % % [TPR4,TNR4,Acc4,BA4,PPV4,NPV4,F14,MCCS4] = myperf(Tvalidate,YPred4);
% % % ---------------------------------------------------------------------------------------------------------------------------------------%
% % % 8. Classification between Normal(A),interictal(C) and seizure(E) 
% rowdist1=[1 ones(1,239)];
% rowdist2=[1 ones(1,59)];
% 
% % % Training results
% T1=[zeros(80,1);ones(80,1);2*ones(80,1)];
% Ttrain=categorical(T1);
% 
% % % Testing results
% T2=[zeros(20,1);ones(20,1);2*ones(20,1)];
% Tvalidate=categorical(T2);
% 
% X1=[KN1(:,1:80),KN3(:,1:80),KP1(:,1:80)];
% X2=reshape(X1',240,L);
% Xtrain = mat2cell(X2,rowdist1);
% 
% X1=[KN1(:,81:100),KN3(:,81:100),KP1(:,81:100)];
% X2=reshape(X1',60,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 3;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net = trainNetwork(Xtrain,Ttrain,layers,options);
% % Testing data
% XTest = Xvalidate ;
% YTest = Tvalidate;
% YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);
% acc = sum(YPred == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred);
% title(' Confusion Matrix A - C - E ')
% fprintf("\n Accuracy of classification between normal(A),interictal(C) and seizure(E)  = %f \n",100*acc);
% 
% c1 = confusionmat(Tvalidate,YPred);
% c=c1';
% CS11=c(1,1)/(c(1,1)+c(2,1)+c(3,1));
% CS12=c(2,2)/(c(1,2)+c(2,2)+c(3,2));
% CS13=c(3,3)/(c(1,3)+c(2,3)+c(3,3));
% fprintf('\n Accuracy of classification of normal =%f\n',100*CS11);
% fprintf('\n Accuracy of classification of interictal =%f\n',100*CS12);
% fprintf('\n Accuracy of classification of ictal =%f\n',100*CS13);
% % ---------------------------------------------------------------------------------------------------------------------------------------%
% 9. Classification between Normal(A,B),interictal(C,D) and seizure(E) 
% % Training samples
% T1=[zeros(160,1);ones(160,1);2*ones(80,1)];
% Ttrain=categorical(T1);
% T2=[zeros(40,1);ones(40,1);2*ones(20,1)];
% Tvalidate=categorical(T2);
% 
% rowdist1=[1 ones(1,399)];
% rowdist2=[1 ones(1,99)];
% 
% O1=[KN1(:,1:80),KN2(:,1:80)];
% O2=[KN3(:,1:80),KN4(:,1:80)];
% X1=[O1,O2,KP1(:,1:80)];
% X2=reshape(X1',400,L);
% Xtrain = mat2cell(X2,rowdist1);
% 
% % % Testing samples
% O3=[KN1(:,81:100),KN2(:,81:100)];
% O4=[KN3(:,81:100),KN4(:,81:100)];
% X1=[O3,O4,KP1(:,81:100)];
% X2=reshape(X1',100,L);
% Xvalidate = mat2cell(X2,rowdist2);
% 
% % % Classification using BiLSTM networks
% inputSize = 1;
% numHiddenUnits = 100;
% numClasses = 3;
% 
% layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,'OutputMode','last')
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% maxEpochs = 200;
% miniBatchSize = 25;
% 
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',maxEpochs, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'GradientThreshold',1, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% net = trainNetwork(Xtrain,Ttrain,layers,options);
% 
% % Testing data
% XTest = Xvalidate ;
% YTest = Tvalidate;
% YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);
% acc = sum(YPred == YTest)./numel(YTest);
% figure;plotconfusion(YTest,YPred);
% title(' Confusion Matrix AB - CD -E ')
% fprintf("\n Accuracy of classification between normal(AB),interictal(CD) and seizure(E)  = %f \n",100*acc);
% 
% c1 = confusionmat(Tvalidate,YPred);
% c=c1';
% CS11=c(1,1)/(c(1,1)+c(2,1)+c(3,1));
% CS12=c(2,2)/(c(1,2)+c(2,2)+c(3,2));
% CS13=c(3,3)/(c(1,3)+c(2,3)+c(3,3));
% fprintf('\n Accuracy of classification of normal =%f\n',100*CS11);
% fprintf('\n Accuracy of classification of interictal =%f\n',100*CS12);
% fprintf('\n Accuracy of classification of ictal =%f\n',100*CS13);
% % ---------------------------------------------------------------------------------------------------------------------------------------%
