clear all
%%

n=500;


fullgraph=ones(n)-eye(n);

Mone=ones(n/2);
Mzero=zeros(n/2);
MATBIP=[Mzero Mone; Mone Mzero];

Aux=diag(ones(1,n-1),1) + diag(ones(1,n-1),-1);
Aux(1,n)=1;
Aux(n,1)=1;

sim=20;
fin=8;

res=zeros(fin,sim,3);

for mm=1:sim
sig=rand(n,1);

for kk=2:fin
    res(kk,mm,1)=PEG(sig',fullgraph,kk,1);
    res(kk,mm,2)=PEG(sig',MATBIP,kk,1);
    res(kk,mm,3)=PEG(sig',sparse(Aux),kk,1);

end
end

%%
for kk=1:3
    data=res(2:8,:,kk);
    y = mean(data,2);
    errors = std(data,0,2);
    x = 2:8;
    h = errorbar(x, y, errors);
    set(h,'LineWidth',3)
    set(gcf,'color','white')
    hold on
end
    hold off
    legend('Complete graph','Bipartite graph','Cycle graph')
    ylim([0 1.01])
    xlim([1.9 8.1])
    set(gca,'FontSize',30)
    xlabel('Parameter {\it m}') 
    ylabel('Entropy value')
saveas(gca,'regular.eps','epsc');

