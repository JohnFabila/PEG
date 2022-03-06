%Temperature with 37 vertices
%%
clear all
S = load('grasp_molene_data.mat');
D=S.molene_graphs{2,1};
D.data_name %data_names    {'temperature'}    {'maximal temperature'}    {'minimal temperature'}
G.coords=D.coordinates  %Coordenadas x,y,z
Mat2=(D.distances); %distance_matrix

%%

Temp=D.data{2,1}-273.15; %temperature
N=37;
M=Mat2;
sigma1= 1.0e+05;
sigma2= 5.1e+09;
for ii=1:N
    for jj=1:N
        if Mat2(ii,jj) >= sigma1
           M(ii,jj)=0;
        else
           M(ii,jj)=exp(-(Mat2(ii,jj))^2/(2*sigma2));
        end  
    end 
end 
Adj=M-eye(N);

%% 
 Min=graph(Adj);


%%all entropy
j1=zeros(744,37);
j2=zeros(744,37);
j3=zeros(744,37);
j4=zeros(744,37);
res=zeros(744,4);
par=744;
for qq=1:744
        x=Temp(:,qq)';
        res(qq,1)=PEG(x,Adj,2,1);
        res(qq,2)=PEG(x,Adj,3,1);
        res(qq,3)=PEG(x,Adj,4,1);
        res(qq,4)=PEG(x,Adj,5,1);
end 
%%

res(662,:)
res(556,:)
%%