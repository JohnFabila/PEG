clear all
load('mydata.mat')

%%
valuem=2:8;
wind=800;
int=400;
Adj1=sparse(diag(ones(1,wind-1),1));
Adj2=sparse(diag(ones(1,wind-1),1) + diag(ones(1,wind-1),-1));
%%
L=1;
for mm=1:10
    [P v]=partition(mydata(mm,:),wind,int);
          for kk=1:v
            for hh=valuem
            res(mm,kk,hh-1)=pec(P{kk},hh,L);
            %res1(mm,kk,hh-1)=PEG(P{kk},Adj1,hh,L); %delete
            res2(mm,kk,hh-1)=PEG(P{kk},Adj2,hh,L);
            {mm,kk,hh-1} %delete
            end
        end   
end
%%
save('res.mat','res')
save('res2.mat','res2')
%%
t=1:v;
for jj=1:5 
    t+v*(jj-1)%delete
    A(t+v*(jj-1),:)=res(jj,:,:);
    B(t+v*(jj-1),:)=res(jj+5,:,:);
    A2(t+v*(jj-1),:)=res2(jj,:,:);
    B2(t+v*(jj-1),:)=res2(jj+5,:,:);
end
%%

%%
    errorbar(valuem, mean(A), std(A)/sqrt(v*5),'--b','LineWidth',3)
    hold on
    errorbar(valuem, mean(B), std(B)/sqrt(v*5),'--r','LineWidth',3)
        hold on
    errorbar(valuem, mean(A2), std(A2)/sqrt(v*5),'b','LineWidth',3)
        hold on
    errorbar(valuem, mean(B2), std(B2)/sqrt(v*5),'r','LineWidth',3)
    hold off
    set(gcf,'color','white')
  xlabel('Parameter \it{m}') 
ylabel('Entropy value')

legend('Elderly (PE)','Young (PE)','Elderly (PE_G)','Young (PE_G)','Location','southwest') 
 xlim([1.9 8.1])
% ylim([0.45 1.02])
hold off
set(gca,'FontSize',30)
saveas(gca,'heart.eps','epsc');