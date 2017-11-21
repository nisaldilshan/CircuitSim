function new_J_table= J_Update(I_table,G_table,J_table,X,size)
    for k=1:size,
            if ((G_table(k,1)==2)) 
                J_table(k,3)= 0-I_table(k,3);
            end
             if ((G_table(k,1)==1)) 
                if (J_table(k,1)==0),
                    v1=0;
                    v2= X(J_table(k,2));
                elseif (J_table(k,2)==0),
                    v1= X(J_table(k,1));
                    v2=0;
                else
                    v1= X(J_table(k,1));
                    v2= X(J_table(k,2));
                end
                J_table(k,3)= G_table(k,4)*(v1-v2);
            end
    end
    new_J_table = J_table;
end
 