
clear all

q=1;
fin=2;
n=2001;
sig={};
res={};
sig{1}=sort(rand(n,1),'descend');
%sig{2}=sort(trnd(1,n,1),'descend');
for tt=1:3
    q=1;
    for k=1:20:(n-1)
    a1=ones(n-k,k);
    a2=ones(k,n-k);
    a3=zeros(n-k,n-k);
    a4=zeros(k,k);
    star=[a4 a2;a1 a3];
    Out_DispEn=PEG(sig{1}',sparse(star),tt+1,1);
    res{tt}(q,1)=Out_DispEn; 
    q=q+1;    
    end
end    

%%
save res
%%
plot(1:20:2001,[res{1}; res{1}(1)],'LineWidth',2.5)
hold on
plot(1:20:2001,[res{2}; res{2}(1)],'LineWidth',2.5)
hold on
plot(1:20:2001,[res{3}; res{3}(1)],'LineWidth',2.5)
hold off
set(gcf,'color','white')
legend('\it{m=2}','\it{m=3}','\it{m=4}','Location','south')
xlim([-4 2005])
ylim([0 1])
xlabel('Complete bipartite graph \it{G_k}') 
ylabel('Entropy value') 
set(gca,'FontSize',30)
saveas(gca,'minimum.eps','epsc');
%%