%Base code
filedir1 = dir('D:/Neuronets/Angry/*.wav');   %list the current folder content for .wav file 
fileRoot1 =  fileparts('D:/Neuronets/Angry/*.wav');
Y1 = cell(1,length(filedir1));  %pre-allocate Y in memory
FS1 = Y1;       %pre-allocate FS in memory 
for i = 1:length(filedir1)  %loop through the file names 
    %read the .wav file and store them in cell arrays 
    str = fullfile(fileRoot1,filedir1(i).name);
    [Y1{i}, FS1{i}] = audioread(str); 
end
for k = 1:length(Y1)
        startSample = FS1{1}*1.0;
        endSample = FS1{1}*3.12;
        Data_angry{1,k} = Y1{1,k}(startSample:endSample);
end

filedir2 = dir('D:/Neuronets/Other/*.wav');   %list the current folder content for .wav file 
fileRoot2 =  fileparts('D:/Neuronets/Other/*.wav');
Y2 = cell(1,length(filedir2));  %pre-allocate Y in memory (edit from @ Werner) 
FS = Y2;       %pre-allocate FS in memory (edit from @ Werner) 
for i = 1:length(filedir2)  %loop through the file names 
    %read the .wav file and store them in cell arrays 
    str2 = fullfile(fileRoot2,filedir2(i).name);
    [Y2{i}, FS2{i}] = audioread(str2); 
end
for k = 1:length(Y2)
        startSample = FS2{1}*1.0;
        endSample = FS2{1}*3.12;
        Data_other{1,k} = Y2{1,k}(startSample:endSample);
end

X_input_an = cell2mat(Data_angry);
X_input_oth = cell2mat(Data_other);

len=1e3;
Nfix=fix(size(X_input_an,1)/len);
Input_data_an=reshape(X_input_an(1:Nfix*len,:),len,[]);
Input_data_oth=reshape(X_input_oth(1:Nfix*len,:),len,[]);

Input_data0 = [Input_data_an Input_data_oth];
Input_data =  normalize(Input_data0);

save 'Input_data'
save 'Input_data_an'
save 'Input_data_oth'
