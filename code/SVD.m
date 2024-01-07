A = [[1,2,3];[2,4,6];[3,7,5]];

[U,S,V] = svd(A);

% Extract singular values from the diagonal matrix S
singular_values = diag(S);

% Set a threshold for zero singular values
threshold = 1e-10;

% Identify indices of zero singular values
indices = find(singular_values < threshold);

% Remove components associated with zero singular values
U_prime = U; U_prime(:, indices) = [];
S_prime = S; S_prime(indices, :) = []; S_prime(:, indices) = [];
V_prime = V; V_prime(:, indices) = [];

% Reconstruct the modified matrix A'
A_prime = U_prime * S_prime * V_prime';

% Display the results
disp('Original Matrix A:')
disp(A)
disp('Modified Matrix A'' (zero singular values removed):')
disp(A_prime)