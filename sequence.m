function [line,num_of_line,space] = sequence(textboxs)
line=[0 0 0 0];
space=[0];
num_of_line=zeros(1,length(textboxs));
while(~isempty(textboxs))
    ymin=textboxs(:,2);
    ymax=ymin+textboxs(:,4);
    yavg=(ymin+ymax)/2;
    in=[(yavg>=textboxs(1,2))&(yavg<=(textboxs(1,2)+textboxs(1,4)))];
    position=find(in);
    temp=textboxs(position,:);
    temp=sortrows(temp,'ascend');
    line=vertcat(line,temp);
    %% line
    num_of_line(size(line,1)-1)=1;
    %% space
    endpoint=temp(:,1)+temp(:,3);
    endpoint(end)=[];
    temp_space=abs(endpoint-temp((2:end),1));
    temp_space=[temp_space>=20];
    space=vertcat(space,temp_space,0);
    textboxs(position,:)=[];
end
line(1,:)=[];
space(1)=[];

end

    

        
        
        
        