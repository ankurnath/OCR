% clc;
% clear all;
% close all;

%% from image to 4D matrix
 T=readall(imds);

bad_image=zeros(35,35,3,length(T));
% train_Y=[];
tic
for i=1:length(T)
       
%     temp_I=T(i);
%     temp_I=cell2mat(T);
      
      temp_I=imresize(cell2mat(T(i)),[35 35]);
       if ismatrix(temp_I)
            temp_I = cat(3,temp_I,temp_I,temp_I);
       end
%     figure
%     imshow(temp_I)
%     train_X=cat(4,temp_I,train_X);
      bad_image(:,:,:,i)=temp_I;
       
end
toc
bad_image=uint8(bad_image);
temp=countEachLabel(imds);
temp=temp(:,2);
temp=table2array(temp);
temp=temp';
load alphabet;
badimage_labels=categorical(cellstr(alphabet));
badimage_labels=repelem(badimage_labels,temp);
