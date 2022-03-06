clear all
%%
x = floor(logspace(2,4,30)); 

for jj = 1:size(x,2)
    %Define the different underlying graphs
    N=x(jj);
    Adj1=ones(N)-eye(N); %Completed graph      
    Adj2=sparse(diag(ones(1,N-1),1)); %Directed Path Graph
    Adj3=sparse(diag(ones(1,N-1),1) + diag(ones(1,N-1),-1)); %Undirected Path Graph     
    Adj4=sparse(diag(ones(1,N-1),1) + diag(ones(1,N-1),-1));
    Adj4(1,N)=1;
    Adj4(N,1)=1; %Cycle graph
    N1=floor(sqrt(N));
    Adj5=sparse(Grid2D8nei(N1,N1)); %Grid or Image graph

   %Compute Entropies and times for 10 samples
        for ii = 1:10
            xe=rand(N,1);
            xe2=xe(1:N1^2,1);
            tic
            res1(jj,ii)=PEG(xe',Adj1,2,1);
            t1(jj,ii) = toc; 
            tic
            res2(jj,ii)=PEG(xe',Adj2,2,1);
            t2(jj,ii) = toc; 
            tic
            res3(jj,ii)=PEG(xe',Adj3,2,1);
            t3(jj,ii) = toc; 
            tic
            res4(jj,ii)=PEG(xe',Adj4,2,1);
            t4(jj,ii) = toc;
            tic
            res5(jj,ii)=PEG(xe2',Adj5,2,1);
            t5(jj,ii) = toc;
            tic
            res6(jj,ii)=pec(xe',2,1);
            t6(jj,ii) = toc;   
            tic
        end
    jj
end

%%
y=[mean(t1,2) mean(t2,2) mean(t3,2) mean(t4,2) mean(t5,2) mean(t6,2)];
loglog(x,y(:,1),x,y(:,2),':',x,y(:,3),'--',x,y(:,4),'-.',x,y(:,5),'-',x,y(:,6),':','LineWidth',2.5)
grid on
set(gcf,'color','white')
xlabel('Number of vertices') 
ylabel('Computational time')
%xlim([100,50000])
legend({'Complete graph','Undirected path','Directed path','Cycle graph','Grid 2D','Time series'},'Location','northwest')
set(gca,'FontSize',30)
saveas(gcf,'time1.eps','epsc');
%%