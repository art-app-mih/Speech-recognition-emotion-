load 'Input_data'
load 'Input_data_an'
load 'Input_data_oth'

ind_an=zeros(2,size(Input_data_an,2));
ind_an(1,:)=1;
ind_oth=zeros(2,size(Input_data_oth,2));
ind_oth(2,:)=1;

T = [ind_an ind_oth]; %target vector

hiddenSize = 10;
autoenc1 = trainAutoencoder(Input_data,hiddenSize,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.02,...
    'DecoderTransferFunction','purelin'); %350 epochs
features1 = encode (autoenc1, Input_data);

autoenc2 = trainAutoencoder(features1,hiddenSize,...
   'L2WeightRegularization',0.01,...
   'SparsityRegularization',6,...
   'SparsityProportion',0.05,...
   'DecoderTransferFunction','purelin',...
   'ScaleData',false);

features2 = encode(autoenc2,features1);
softnet = trainSoftmaxLayer(features2,T, 'LossFunction' , 'crossentropy');

deepnet_1 = stack(autoenc1, autoenc2, softnet);
deepnet_1 = train(deepnet_1,Input_data,T);
sign_type = deepnet_1(Input_data);
plotconfusion(T, sign_type);

save ('deepnet_1');
