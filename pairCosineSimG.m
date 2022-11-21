function pairMat = pairCosineSimG(dataTensor) 
    % computes the pairwise cosine similarity of layers in dataTensor (3D),
    % each datapoint correpsonds to a layer
    % or dataTensor can be a matrix, in which case it assumes that
    % rows correspond to observations, columns to features
    % if data is actually a vector, simply add singleton dummy layer
    [nr,nc,nl] = size(dataTensor);
    if nl == 1
        dataReshape = dataTensor';
    else
        dataReshape = reshape(dataTensor,nr*nc,nl);
    end
    pairMat = dataReshape'*dataReshape;
    pairMat = (1./sqrt(diag(pairMat)')).*pairMat.*(1./sqrt(diag(pairMat)));
end