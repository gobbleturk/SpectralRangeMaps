function [sparseSimMat] = sparsifySimilarityMatrix(simMat,k)
    % Input: nScenario x nScenario simMat
    % Output: Sparsified nCenario x  nScenario simMatrixed
    % the matrix is sparsified by retaining only those entries
    % which are within the k values in the row or column excluding the 
    % diagonal.
    % The non retained values including the diagonal is set to 0.

    simNN = sim2nnG(simMat,k);
    sparseSimMat = simMat.*simNN;
