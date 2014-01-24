function F = vertcat( varargin )
%VERTCAT Vertical concatenation of chebfun2 objects.
%
% VERTCAT(F, G) is the vertical concatenation of chebfun2 objects F and G, and this
% function returns a chebfun2v object. 
% 
% [F ; G] is different syntax for VERTCAT(F, G)
% 
% See also CHEBFUN2V.

% Copyright 2013 by The University of Oxford and The Chebfun Developers.
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

if ( nargin > 1 )
    % call the chebfun2v constructor.
    F = chebfun2v( varargin );
else
    error('CHEBFUN2:VERTCAT','Cannot vertically concatenate more than three chebfun2 objects.');
end
    

end