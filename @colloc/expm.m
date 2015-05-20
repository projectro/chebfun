function [E, P] = expm(disc, t)
%EXPM   Operator exponential for COLLOC discretization.
%   This EXPM is called by LINOP.EXPM to perform propagation of a discrete
%   initial condition via matrix exponential. The returned matrix is the
%   propagator for a discretization of the problem.
%
% See also LINOP.EXPM.

% Copyright 2015 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

if ( t == 0 )
    
    % Trivial case at t = 0
    [ignored, P, ignored] = matrix( disc );
    E = eye(size(P, 2));
    
else
    
    % We need a copy of the matrix discretized without any side conditions.
    [PA, P, B] = matrix( disc );
    
    % Reduced and original degrees of freedom.
    [mRed, mOrig] = size(P);  
    
    % This step implicitly uses the side conditions in order to lift a reduced
    % discretization to full size.
    Q = [B ; P] \ [zeros(mOrig - mRed, mRed) ; eye(mRed)];

    % Propagator of the "reduced" variables: Lift to full size, apply original
    % operator, project down to reduced size, then exponentiate. 
    PA(1:size(B,1 ),:) = [];
    E = expm(t*PA*Q);
    
    % Propagator for the original variables: Reduce, propagate, lift. 
    E = Q*E*P;

end

end
