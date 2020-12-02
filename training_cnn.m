layers = [imageInputLayer([35 35 3]);
          convolution2dLayer(3,32);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
          convolution2dLayer(3,32);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
%           convolution2dLayer(3,64);
%           reluLayer();
%           convolution2dLayer(3,64);
%           reluLayer();
%           maxPooling2dLayer(2,'Stride',2);
          fullyConnectedLayer(62);
          softmaxLayer();
          classificationLayer()];
      
options = trainingOptions('sgdm','MaxEpochs',30,'InitialLearnRate',0.0001,'MiniBatchSize',100,'Verbose',true);
rng('default') % For reproducibility n 
%   all_image=cat(4,char74_train,new_image,bad_image);
%   all_labels=vertcat(char74_labels,new_image_labels,badimage_labels);
net = trainNetwork(final_database,final_labels,layers,options);
% save('H:\final\final_cnn.mat','net','layers','options');