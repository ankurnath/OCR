% load training_cnn;
%  load rotated_cnn;
%  load all_image_cnn;
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
