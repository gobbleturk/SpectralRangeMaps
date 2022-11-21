function [l,lSym,lRW] = computeLaplacianG(w)
% calculates unnormalized and normalized graph laplcians of input
% symmetric non-negative matrix w
% The output laplacian l and its normalizations has the same 
% dimensions as W
[dMat, dVec] = calcD(w);
l = dMat - w;
lSym = dVec.^(0.5) .* l .* (dVec.^(0.5)');
lRW = 1./(dVec) .* l;

end

function [dMat,dVec]= calcD(W)
%dVec is the indegree of each node, assuming W is symmetric
dVec = sum(W,2); %W is symmetric, can use 1 or 2 - this is a colulmn vector
dMat = diag(dVec);
end