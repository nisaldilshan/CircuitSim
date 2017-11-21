function new_I_table= I_Update(I_table,G_table,J_table,X,size)
    for j=1:size,
            if (I_table(j,1)==0),
                v1=0;
                v2= X(I_table(j,2));
            elseif (I_table(j,2)==0),
                v2=0;
                v1= X(I_table(j,1));
            else
                v1= X(I_table(j,1));
                v2= X(I_table(j,2));
            end
            if ((G_table(j,1)==2))            
                I_table(j,3)= G_table(j,4)*(v1-v2) - J_table(j,3);
            end
            if  ((G_table(j,1)==1)) 
                I_table(j,3)= G_table(j,4)*(v1-v2) + J_table(j,3);
            end
    end
    new_I_table =  I_table;
end