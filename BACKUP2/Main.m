clear all;
close all;

% read values from netlisfile
fname =  'fileRLC_SINE.txt';
[Name N1 N2 arg3 type freq]=textread(fname,'%s %s %s %s %s %s '); 

Inverted_A = function_A(fname);

numNode=0;  %Number of nodes, not including ground (node 0).
numVolSource =0;
L_count = 0;
C_count = 0;
%Declare V SOURCE table
V_SOURCE = zeros();

%output Vectors
out_vect1 = [];
out_vect2 = [];

for i=1:length(Name),
    numNode=max(str2num(N1{i}),max(str2num(N2{i}),numNode));
    if(Name{i}(1)=='V')
        numVolSource = numVolSource+1;
        V_SOURCE(numVolSource,1) = str2num(arg3{i});
        if(strcmp(type{i},'sine'))
            V_SOURCE(numVolSource,2) = 1;
        elseif(strcmp(type{i},'square'))
            V_SOURCE(numVolSource,2) = 2;
        else
            V_SOURCE(numVolSource,2) = 0;
        end
    elseif(Name{i}(1)=='C')
        C_count = C_count+1;
    elseif(Name{i}(1)=='L')
        L_count = L_count+1;
    end    
end

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
sim_end_time = 15/10000;

%variable set for switches with T and T_on
%
%variable set for each voltage source with TYPE, T and T_on
%
%variable set for each current source with TYPE, T and T_on
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initial Loop - used to initialize variables which need to update only once
G_src_count = 0;
for i=1:length(Name) %UPDATE G TABLE
    if(Name{i}(1)=='C')
        G_src_count = G_src_count + 1;
        G_table(G_src_count,1) = 1; % CAPACITOR
        G_table(G_src_count,2) = str2num(N1{i});
        G_table(G_src_count,3) = str2num(N2{i});
        G_table(G_src_count,4) = str2num(arg3{i})/timestep;
    elseif(Name{i}(1)=='L')
        G_src_count = G_src_count + 1;
        G_table(G_src_count,1) = 2; % INDUCTOR
        G_table(G_src_count,2) = str2num(N1{i});
        G_table(G_src_count,3) = str2num(N2{i});
        G_table(G_src_count,4) = timestep/str2num(arg3{i});
    end   
end

J_src_count = 0;
for i=1:length(Name) % INITIAL UPDATE J TABLE
    if(Name{i}(1)=='C' || Name{i}(1)=='L')
        J_src_count = J_src_count + 1;
        J_table(J_src_count,1) = str2num(N1{i});
        J_table(J_src_count,2) = str2num(N2{i});
        J_table(J_src_count,3) = 0;
    end
end

for i=1:length(J_table(:,1)) % INITIAL UPDATE I TABLE
        I_table(i,1) = J_table(i,1);
        I_table(i,2) = J_table(i,2);
        I_table(i,3) = 0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%main Loop
while(total_time <= sim_end_time)
    
	total_time = total_time + timestep;  
    
    %Voltage Source update
    for i=1:numVolSource
        V_SOURCE(i,1) = waveform_gen(V_SOURCE(i,2), 5, 0, total_time, (1/50000));
    end
    
    
    % call I_Update function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I_table = I_Update(I_table,G_table,J_table,X,L_count+C_count);
    
    % call J_Update function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    J_table = J_Update(I_table,G_table,J_table,X,L_count+C_count);
    
    
    
    %%%%%%%%  CREATE Z MATRIX   %%%%%%%%%%
    for i=1:numNode
        sum = 0; 
        for k=1:C_count+L_count
            if(J_table(k,1)==i)
                sum = sum + J_table(k,3);
            elseif(J_table(k,2)==i)
                sum = sum - J_table(k,3);
            end
        end
        Z(i) = sum;
    end
    
    for i = numNode+1:numNode+numVolSource
        Z(i) = V_SOURCE(i-numNode,1);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    X = Inverted_A * Z;
    
    out_vect1 = [out_vect1; X(2)];
    out_vect2 = [out_vect2; X(3)];
end

plot(out_vect1);
title('v1');
xlabel('time(s)');
ylabel('voltage(V)');

figure;
plot(out_vect2);
title('v1');
xlabel('time(s)');
ylabel('voltage(V)');