clc
close all;
clear all;

class=62;
catagories=cell(1,class);
load alphabet

for i=1:class
    if(i<10)
    str=sprintf('Sample00%d',i);
    catagories(i)=cellstr(str);
    else
        str=sprintf('sample0%d',i);
        catagories(i)=cellstr(str);
    end
end
rootfolder=fullfile('BAD_Bmp');
imds = imageDatastore(fullfile(rootfolder,catagories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds);
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% 
% Use splitEachLabel method to trim the set.
% imds = splitEachLabel(imds, minSetCount, 'randomize');
% 
% Notice that each set now has exactly the same number of images.
countEachLabel(imds);
% %  s = datastore(fullfile('new'),...
% % 'IncludeSubfolders', true,'FileExtensions', '.jpg','Type', 'image');
% 
%  imds = shuffle(imds);
% train_labels=imds.Labels;
% train_labels=double(train_labels);
% class=zeros(62,7705);
% for i=1:length(train_labels)
%     I=read(imds);
%     I = imresize(I, [32 32]);
%     I=I(:);
%     I=I';
%     if ( length(I)==3072) 
%     train_data(i,:)=I;
%     class(i,1)=train_labels(i,1);
%     end
%     
% end

%double char str2num

% name=zeros(1,62);
% for i=1:62
%     if i<=10
%         temp=char(i+47);
%         alphabet(i,1)=temp;
%     elseif i>10 & i<=36   
%       temp=char(i+54);
%       alphabet(i,1)=temp;
%     else 
%            temp=char(i+60);
%            alphabet(i,1)=temp;
%     end
% end
    
 



