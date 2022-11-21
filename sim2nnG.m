function nnMat = sim2nnG(simMat,k)
% Converts a similarity matrix into a nearest neighbor one, taking first
% k neighbors. The output matrix nnMat will have a value of 1 at i,j
% iff i!=j and either simMat(i,j) is one of the largest values or row i
% or column j (ignoring the values on the diagonal).
% Inputs:
%    simMat: is an n x n matrix of similarities
%    k: the number of nearest neighbors
% Outputs:
%    nnMat: binary n x n matrix of nearest neighbors 

[n,~]= size(simMat);

% set diagonal to -inf so self edges are not counted
for i= 1 : n
    simMat(i,i) = -inf;
end

nnMat = zeros(n,n);
k = min(k,n-1);
for i = 1 : n
    [~,nbrs] = sort(-simMat(:,i));
    nbrs=nbrs(1:k);
    nnMat(i,nbrs) = 1;
end

% symmetrize
nnMat = nnMat+nnMat';
nnMat(nnMat >1) = 1;