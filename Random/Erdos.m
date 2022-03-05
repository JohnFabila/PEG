%%
clear all
%%
n=2000;
sig=rand(n,1);


%examgraph=random_graph(n,.1);

%plot(graph(examgraph))
fin=8;
sim=20;
res=zeros(fin,sim,4);


for mm=1:sim
        examgraph=sparse(random_graph(n,.1));
        examgraph2=sparse(random_graph(n,.3));
        examgraph3=sparse(random_graph(n,.6));
        examgraph4=sparse(random_graph(n,.9));
        for kk=2:fin
            res(kk,mm,1)=PEG(sig',examgraph,kk,1);
            res(kk,mm,2)=PEG(sig',examgraph2,kk,1);
            res(kk,mm,3)=PEG(sig',examgraph3,kk,1);
            res(kk,mm,4)=PEG(sig',examgraph4,kk,1);
        end
    
end
%%

ls={':','--','-','-.'};
for hh=1:4
    data=res(2:fin,:,hh)';
    y = mean(data);
    errors = std(data);%/sqrt(sim);
    x = 2:(size(data,2)+1);
    h = errorbar(x, y, errors);
    set(h,'linestyle',ls{hh},'LineWidth',2.5)
    %set(h,'linestyle','none')
    hold on


end
hold off
set(gca,'FontSize',45)

    legend('p=0.1','p=0.3','p=0.6','p=0.9')
    ylim([0.25 1.01])
    xlim([1.9 8.1])
    xlabel('Parameter {\it m}') 
ylabel('Entropy value') 
saveas(gcf,'random.png')
saveas(gca,'random.eps','epsc');