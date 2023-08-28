function [Out_PEG, npdf]=PEG(x,Adj,m,L)
% This function calculates permutation entropy for graphs (PEG).
% It works for Adjacency matrix (directed and undirected graphs) and also
% weighted graphs.
%
% Inputs:
%
% x: graph signal - a vector of size 1 x N (the number of vertices)
% Adj: square matrix N x N  The elements of the matrix indicate whether pairs of vertices are adjacent or not in the graph.
% m: embedding dimension
% L: time delay
%
% Output:
% Out_PEG: a scalar value between 0 and 1 giving the Permutation Entropy value of the graph signal.
% npdf: Normalised probability density function of graph permutation patterns.
%
%Ref: J.S. Fabila-Carrasco, C. Tan, and J. Escudero, “Permutation Entropy for Graph Signals”, arXiv preprint, 2021  
%arXiv:2110.00628 
%
% Emails: john.fabila@ed.ac.uk / javier.escudero@ed.ac.uk
%  11-February-2021
%

%%  


%%Default to some input parameters for clarity and to control errors.
if nargin > 4
    error('Too many inputs');
end
if nargin < 4
    L = 1;
end
if nargin < 3
    m = 2;
end
if nargin < 2
    error('Too few inputs');
end

% Initial checks
N = length(x); % N=number of vertices

if or(size(Adj,1)~=N, size(Adj,2)~=N )
    error('not a square matrix');
else
    % Step 1: Matrix Lap where first column is the signal, and the columns the
    % j-average
    Lap(:,1)=x';%First Column is the signal
    Aux=eye(N);
    t=2;
    %Each column of Lap is an average of the j-neighbourhoods
    for j=L:L:(m-1)*L
        Aux=Aux*(Adj^(L));
        Lap(:,t)=sparse(diag(1./sum(Aux,2)))*(Aux*x');
        t=t+1;
    end
    
    %%Delete row, only it is used for directed graphs, otherwise, this step
    %%does not do nothing
    Lap(any(isnan(Lap),2),:) = [];
    N=size(Lap,1);
        
    % Step 2: Generation of all possible Permutation Entropy
    permlist = perms(1:m);%patterns
    pat=length(permlist);%number of patterns
    pdf=zeros(1,pat);
    for j=1:N
        [~,index]=sort(Lap(j,:));
        for jj=1:pat
            if abs(permlist(jj,:)-index)==0
                pdf(jj) = pdf(jj) + 1 ;
            end
        end
    end
    
    % Step 3: Calculation of  pattern frequency in the graph
    npdf = pdf/N;
    p=npdf(npdf~=0);
    Out_PEG =(-sum(p .* log(p)))/log(factorial(m));
end

end % End of function
