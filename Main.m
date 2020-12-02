clc;
clear all;
close all;
%% getting a file 
[fname, path]=uigetfile('*.*','enter a image');
fname=strcat(path,fname);
colorImage  =imread(fname);
 if ismatrix(colorImage)
           colorImage = cat(3,colorImage,colorImage,colorImage);
       end


% colorImage =imrotate(colorImage,20,'bicubic');
imshow(colorImage)
title('Input image')
pause(2)

%% Use the detectMSERFeatures function to find all the regions within the image
I = rgb2gray(colorImage);

% Detect MSER regions.
[mserRegions, mserConnComp] = detectMSERFeatures(I, ...
    'RegionAreaRange',[100 8000],'ThresholdDelta',4);


%% getting bounding box

mserStats = regionprops(mserConnComp, 'BoundingBox');
textboxs = vertcat(mserStats.BoundingBox);


textboxs=unique(textboxs,'rows');
% textboxs=sortrows(textboxs,[2 1],{'ascend','ascend'});
i=1;
n=size(textboxs,1);
while (i<size(textboxs,1))
    x=textboxs(i,1);
    y=textboxs(i,2);
    xmin=textboxs(:,1);
    ymin=textboxs(:,2);
pixeldiff_x=abs(x-xmin);
pixeldiff_y=abs(y-ymin);
position=(pixeldiff_x >15 | pixeldiff_y >15);
position(i)=1;
textboxs((position==0),:,:,:)=[];
i=i+1;
n=length(textboxs);
end



%% removing contour inside a letter



    x=textboxs(:,1);
    y=textboxs(:,2);
    w=textboxs(:,3);
    h=textboxs(:,4);
    xmax=x+w;
    ymax=y+h;
    remove=[0];

for i=1:size(textboxs,1)
         xv=[x(i),xmax(i),xmax(i),x(i),x(i)]'; %bounding box 
         yv=[y(i),y(i),ymax(i),ymax(i),y(i)]'; %bounding box
         
         in_min = inpolygon(x,y,xv,yv);
         in_max=  inpolygon(xmax,ymax,xv,yv);
         
         in =in_min.*in_max;
          if (sum(in)<=2)
          in(i)=0;
          position=find(in==1);
        
          else 
          position=i;
          
end
         
      position=position';  
      remove=[remove,position];   
    
    
end
remove(1)=[];

for i=1:length(remove)

textboxs((remove(i)-i+1),:)=[];

end
    



    
%%  insert shape    
Itextboxs= insertShape(colorImage,'Rectangle',textboxs,'LineWidth',2,'color','red');
figure
imshow(Itextboxs)
title('Character Detected in input image')

Icropped=[];
textboxs=sortrows(textboxs,[2 1],{'ascend','ascend'});
%% detecting space and line 
[textboxs,line,space]=sequence(textboxs);
for i=1:size(textboxs,1)
     temp_I= imcrop(colorImage,textboxs(i,:));
     temp_I=imresize(temp_I,[35 35]);
     Icropped=cat(4,Icropped,temp_I);
  
end

%% loading  CNN and classification(detected texts are written in ocr text file)  
load final_cnn;
clear result;
fid = fopen('ocr.txt', 'w');

for i=1:size(Icropped,4)
       [result(i),score]=classify(net,Icropped(:,:,:,i));  
       fprintf(fid,'%s',result(i));
       
       if( space(i)==1)
           fprintf(fid,'%s',' ');
       end
       if ( line(i)==1)
           fprintf(fid,'\n');
       end

end



