clear all
%%
I1 = imread('P1.jpg');
I2 = imread('S1.jpg');
I3 = imread('P2.jpg');
I4 = imread('S2.jpg');
I5 = imread('P3.jpg');
I6 = imread('S3.jpg');
I7 = imread('P4.jpg');
I8 = imread('S4.jpg');
I9 = imread('P5.jpg');
I10 = imread('S5.jpg');
I11 = imread('P6.jpg');
I12 = imread('S6.jpg');
I={I1 I2 I3 I4 I5 I6 I7 I8 I9 I10 I11 I12};
%%
for kk=1:12
I{kk} = mat2gray(I{kk});
end
%%

n=230;
sig={};
matcol={};
for kk=1:12
sig{kk}= I{kk}(1:n,1:n);
matcol{kk}=reshape(sig{kk},1,[]); 
end

A=sparse(triu(Grid2D8nei(n,n)));

%%
for mm=1:12
    for kk=4
    res(mm,1)=PEG(matcol{mm},A,kk,1);
    end
end
%%
res
%%