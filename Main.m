% read values from netlisfile
[Name N1 N2 arg3]=textread(fname,'%s %s %s %s '); 

% separate matlab file to get A matrix
Inverted_A = get_inverted_A();

%Declare X matrix
%
%Declare Z matrix
%


%Declare I table
%
%

%Declare J table
%
%

%Declare G table
%
%

%Declare CAP_IND table
%
%



timestep = 1/10000000;
total_time = 0;
sim_end_time = 1/1000;



%variable set for switches with T and T_on
%
%
%

%variable set for each voltage source with TYPE, T and T_on
%
%

%variable set for each current source with TYPE, T and T_on
%
%


%Initial Loop - used to initialize variables which need to update only once
while() %loop till values of necessary variables get updated
{

}


%main Loop
while(total_time <= sim_end_time)
{
	total_time = total_time + timestep;

}