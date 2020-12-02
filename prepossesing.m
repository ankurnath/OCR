clc;
clear all;
close all;
tic;
load 'char74_labels.mat';
load 'char74_train.mat';
load 'char74_num_of_images.mat';
load alphabet;
add_image=600-num_of_images;
new_image=zeros(35,35,3,1);
temp1=0;
start=1;
for i=1:62
%     temp1=temp1+add_image(i);
    finish=start+num_of_images(i)-1;
    temp=char74_train(:,:,:,(start:finish));
    temp2=size(temp);
    rot=ceil(add_image(i)/temp2(4));
    remain=mod(add_image(i),temp2(4));
    for j=1:rot
        angle=randi([-30 30],1,1);
        while(angle==0)
            angle=randi([-30 30],1,1);
        end
        if (j==rot & remain~=0)
            rotated=imrotate(temp(:,:,:,(1:remain)),angle,'crop','bicubic');
            new_image=cat(4,new_image,rotated);
            break;
        end
        rotated=imrotate(temp,angle,'crop','bicubic');
        new_image=cat(4,new_image,rotated);
    end
%     if(length(new_image)~=temp1+1)
%     size(new_image)
%     end
    
 start=finish+1;
end
new_image(:,:,:,1)=[];
new_image_labels=categorical(cellstr(alphabet));
new_image_labels=repelem(new_image_labels,add_image);


    
toc

