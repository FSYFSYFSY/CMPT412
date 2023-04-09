

%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix

for i=1 : 100 : size(xtest, 2)
     [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
     [~,max_P] = max(P,[],1);
     prediction(:, i:i+99) = max_P;
end
confusionchart(confusionmat(ytest, prediction),(0:9))

%The comment and output will be shows on Report.PDF



% % We choose a threshold which has p <= 0.025 is False negative, p >= 0.975 is 
% % True positive, 0.025 < p < 0.5 is True Negative, 0.5 <= p < 0.975 False Positive. 
% % We store it into Most2_conf - The most two confusing feature has largest number of value in the range.  
% % Confusion map is stored in Conf_Mat, which is a 2 x 2 (T/F * Positive/Negative) x Feature_number
% 
% % Most2_Conf = zeros(1,2); % Top 2 Confusion
% % Feature_num = size(P,1);
% % Conf_Mat = zeros(2,2,Feature_num); % Confusion matrix
% % Ker = P;
% % 
% % Ker(Ker <= 0.025) = 0;
% % Ker(Ker >= 0.975) = 1;
% % Ker(Ker > 0.025 & Ker < 0.5) = 0.25;
% % Ker(Ker < 0.975 & Ker >= 0.5) = 0.75;
% % 
% % for i = 1 :Feature_num
% %     Conf_Mat(1,1,i) = length(find(Ker(i,:) == 1));
% %     Conf_Mat(1,2,i) = length(find(Ker(i,:) == 0.75));
% %     Conf_Mat(2,1,i) = length(find(Ker(i,:) == 0.25));
% %     Conf_Mat(2,2,i) = length(find(Ker(i,:) == 0));
% % end
% % 
% % Mat = zeros(1,Feature_num);
% % 
% % for i = 1 : Feature_num
% %     Mat(1,i) = length(find(Ker(i,:) > 0 & Ker(i,:) < 1));
% % end
% % 
% % [Max_value, index] = max(Mat);
% % Most2_Conf(1) = index;
% % Mat(index) = 0;
% % 
% % [Max_value, index] = max(Mat);
% % Most2_Conf(2) = index;
% % Mat(index) = 0;


