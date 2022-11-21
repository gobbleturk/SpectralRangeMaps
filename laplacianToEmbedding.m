function [spectralEmbedding] = laplacianToEmbedding(laplacian,numOutputDim)
% Returns the spectral embedding starting from a (normalized) lapacian.
% The embedding is given by the first non-trivial eigenvectors of
% the graph Laplacian.
% Inputs:
%   laplacian: n x n graph matrix (already normalized)
% Outputs:
%   spectralEmbedding is an n x numOutputDim embedding produced during the
%   spectral clustering method.

imagThresh = 1e-7; %sometimes taking eigs give imaginary components

[n,~] = size(laplacian);
numOutputDim = min(numOutputDim,n);

laplacian = laplacian + eye(n); %The laplacian will have eigenvalues
% of zero (bad conditioning). Adding the identity retains the eigenvectors
% while improving the conditioning.

try
    [spectralEmbedding,~] = eigs(laplacian,numOutputDim,'smallestabs');
catch
    warning('Computing smallest eigs failed, Now trying to compute ALL eigs');
    % Possibly this works because you cannot cutoff eigenvalues exactly at
    % numOutputDim if they cluster there
    try
        [~,spectralEmbedding] = eigs(laplacian);
        spectralEmbedding = spectralEmbedding(:,end-(k-1):end);
    catch
        [n,~] = size(w);
        warning(' Even computing all eigs failed, setting y to the zero %d-%d matrix',n,k);
        spectralEmbedding = zeros(n,k);
    end
end
spectralEmbeddingImag = imag(spectralEmbedding);
if norm(spectralEmbeddingImag) > imagThresh
    warning('Signiciant Imaginary Component in eigenvectors of Laplacian');
end
spectralEmbedding = real(spectralEmbedding);
