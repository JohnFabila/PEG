clear all
%%
count=1;
rep=20; %reperitions
res=zeros(rep,4);

vector=10:10:100; %change2
const=size(vector,2);
RESU={};
for n=vector
   RES{count}=zeros(rep,3);
   X=zeros(n,n);
   A=Grid2D8nei(n,n);
   B=triu(A);          
        for kk=1:rep
            t=1;
            for q=[.1 .25 .5 .9]
            Z=binornd(1,q*ones(n));
            Y=2*rand(n,n)*sqrt(3)-sqrt(3);
            for i=1:n
                for j=1:n
                    X(i,j)=(1-Z(i,j))*(sin(2*pi*i/12)+sin(2*pi*j/12))+Z(i,j)*Y(i,j);
                end
            end
            matcol=reshape(X,1,[]); 
            res1(kk,t)=PEG(matcol,sparse(B),6,1);
            t=t+1;
            end
            {kk,t}
        end
       
RESU{count}=res1; 
count=count+1;
end    

%%

for kk=1:4
       for mm=1:const
           RES1{kk}(:,mm)=RESU{mm}(:,kk);
       end    
end
%%

ls={':','--','-','-.'};
for jj=1:4
    clear data
    data=RES1{jj};
    y = mean(data);
    errors = std(data);%/sqrt(sim);
    x = vector;
    h = errorbar(x, y, errors);
    set(h,'linestyle',ls{jj},'LineWidth',2.5)
    hold on
    set(gcf,'color','white')
    ylim([0 1])
    xlabel('Image size') 
    ylabel('Entropy value')
%end
end

xlim([9 101])
ylim([.32 .85])
hold off
legend('p=0.1','p=0.25','p=0.5','p=0.9','Location','southeast')
set(gca,'FontSize',30)
saveas(gca,'ImageSize.eps','epsc');
%%
save('RES1.mat','RES1')