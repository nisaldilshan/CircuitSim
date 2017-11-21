fname =  'circuit2.txt';
[Name N1 N2 arg3]=textread(fname,'%s %s %s %s ');

T = 1/10000000;     %sampling time

numNode =0;         %Number of nodes, not including ground (node 0).
numVolSource =0;    %Number of voltage sources

%%%%%%%% Calculate number of Nodes and Voltage sources %%%%%%%%%
for i=1:length(Name),
    numNode=max(str2num(N1{i}),max(str2num(N2{i}),numNode));
    if Name{i}(1)=='V'
        numVolSource = numVolSource+1;
    end    
end

%%%%%%%%%%%%%%%%%%%%%%%%% Initiate matrices %%%%%%%%%%%%%%%%%%%%
G=zeros(numNode,numNode);
B=zeros(numNode,numVolSource);
C=zeros(numVolSource,numNode);
D=zeros(numVolSource,numVolSource);

%%%%%%%%%%%%%%%%%%%%%%%%% G Matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:numNode,
    for j=i:numNode,
        for k=1:length(Name),
            if ((i==j)&& ((i==str2num(N1{k}))||(j==str2num(N2{k}))))
               switch(Name{k}(1)),
                   case 'R',
                        G(i,j)= G(i,j) + 1/str2num(arg3{k});  
                   case 'L',
                        G(i,j)= G(i,j) + T/str2num(arg3{k});
                   case 'C',
                        G(i,j)= G(i,j) + str2num(arg3{k})/T;
                   case 'D',
                        G(i,j)= G(i,j) + str2num(arg3{k});
               end
            else
                if (((i==str2num(N1{k}))&&(j==str2num(N2{k}))))
                   switch(Name{k}(1)),
                       case 'R',
                            G(i,j)= G(i,j) - 1/str2num(arg3{k});
                            G(j,i)= G(j,i) - 1/str2num(arg3{k});  
                       case 'L',
                            G(i,j)= G(i,j) - T/str2num(arg3{k});
                            G(j,i)= G(j,i) - T/str2num(arg3{k});
                       case 'C',
                            G(i,j)= G(i,j) - str2num(arg3{k})/T;
                            G(j,i)= G(j,i) - str2num(arg3{k})/T;
                       case 'D',
                            G(i,j)= G(i,j) - str2num(arg3{k});
                            G(j,i)= G(j,i) - str2num(arg3{k});
                   end               
               end
            end
        end      
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%% B Matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(Name),
    if ((Name{i}(1)=='V'))
        if (str2num(N1{i})~=0)
            B(str2num(N1{i}),i)=1;
        end
        if (str2num(N2{i})~=0)
            B(str2num(N2{i}),i)=-1;
        end
    end    
end

%%%%%%%%%%%%%%%%%%%%%%%%% C Matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C = transpose(B);

%%%%%%%%%%%%%%%%%%%%%%%%% A Matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = [G B;C D];

