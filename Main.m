% read values from netlisfile
fname =  'file.txt';
[Name N1 N2 arg3]=textread(fname,'%s %s %s %s '); 

numNode=0;  %Number of nodes, not including ground (node 0).
numVolSource =0;
L_count = 0;
C_count = 0;

for i=1:length(Name),
    numNode=max(str2num(N1{i}),max(str2num(N2{i}),numNode));
    if(Name{i}(1)=='V')
        numVolSource = numVolSource+1;
    elseif(Name{i}(1)=='C')
        C_count = C_count+1;
    elseif(Name{i}(1)=='L')
        L_count = L_count+1;
    end    
end

% separate matlab file to get A matrix
%Inverted_A = get_inverted_A();

%Declare X matrix
X=zeros(numNode+numVolSource,1);
%Declare Z matrix
Z=zeros(numNode+numVolSource,1);


%Declare I table
I_table = zeros(L_count+C_count,3);

%Declare J table
J_table = zeros(L_count+C_count,3);

%Declare G table
G_table = zeros(L_count+C_count,4);


timestep = 1/10000000;
total_time = 0;
sim_end_time = 1/1000;


%variable set for switches with T and T_on
%

%variable set for each voltage source with TYPE, T and T_on
%

%variable set for each current source with TYPE, T and T_on
%


%Initial Loop - used to initialize variables which need to update only once
for i=1:length(Name)%loop till values of necessary variables get updated
    if(Name{i}(1)=='C')
        G_table(i,1) = 'C';
        G_table(i,2) = N1(i);
        G_table(i,3) = N2(i);
        G_table(i,4) = arg3(i)/timestep;
    elseif(Name{i}(1)=='L')
        G_table(i,1) = 'L';
        G_table(i,2) = N1(i);
        G_table(i,3) = N2(i);
        G_table(i,4) = timestep/arg3(i);
    end
end


%main Loop
while(total_time <= sim_end_time)
    
	total_time = total_time + timestep;
    
    

    for i=1:numNode
        Z(i)= 
    end
    
    X = Inverted_A * Z;
end
