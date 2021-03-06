
clear all
%%
%sequence is chaotic where 3.57 < r < 4.
% r parameter for chaotic regime r = 3.8;%
a1=3.55;
a2=4.00;
def=10e-5;
auxi=length(a1:def:a2);
res=zeros(auxi,2);
in=3;

siz = 2^12; % size of chaotic array

j=1;

k=2^10; %delete trascient

N=siz-k+1;
DPath=sparse(diag(ones(1,N-1),1));
UPath=sparse(transpose(DPath)+DPath);
for r=a1:def:a2
    xe=zeros(siz,1);
    xe(1,1)= 0.65; % initial value
    for i=1:siz-1
       xe(i+1,1) = r*xe(i,1)*(1-xe(i,1));
    end
    res(j,1)=pec(xe(k:end,1)',in,1);
    res(j,2)=PEG(xe(k:end,1)',UPath,in,1);
end


%%
figure(1)
plot(a1:def:a2,res(:,1),'-.','LineWidth',2)
hold on
plot(a1:def:a2,res(:,2),'LineWidth',2)
hold on
hold off
axis tight
%set(gcf,'color','white')
set(gca,'FontSize',45)
legend('PE   m=3 and L=1','PE_G m=3 and L=1','Location','south')
xlim([3.55 4])
ylim([.35 1])
xlabel('Parameter {\it{r}}')
ylabel('Entropy value')

%%
saveas(gca,'LogisticMap3.eps','epsc');
save('Log2.mat','res')

%%
