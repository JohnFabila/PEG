function [P v]=partition(x,spa,int)
    np=size(x,2);
    v=floor((np-spa)/(spa-int));
    for ii=1:v+1
           cad=(1:spa)+((spa-int)*(ii-1));
           A{ii}=x(cad);  
    end
  P=A;
    
    