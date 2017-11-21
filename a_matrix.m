fname =  'file.txt';
[Name N1 N2 arg3]=textread(fname,'%s %s %s %s ');

numNode=0;  %Number of nodes, not including ground (node 0).
T = 1/10000000;

for i=1:length(Name),
    numNode=max(str2num(N1{i}),max(str2num(N2{i}),numNode));
end

G=zeros(numNode,numNode);

for i=1:numNode,
    for j=1:numNode,
        for k=1:length(Name),
            if ((i==j)&& ((i==str2num(N1{k}))||(j==str2num(N2{k}))))
               switch(Name{k}(1)),
                   case 'R',
                        G(i,j)= G(i,j) + 1/str2num(arg3{k});  
                   case 'L',
                        G(i,j)= G(i,j) + T/str2num(arg3{k});
                   case 'C',
                        G(i,j)= G(i,j) + str2num(arg3{k})/T;
               end
            else
                
            end
        end        
    end
end