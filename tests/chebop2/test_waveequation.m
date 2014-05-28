function pass = test_waveequation( prefs )
% Testing the wave equation on a non-square domain.  This tests if the domain is
% being treated properly and if Neumann boundary conditions are being dealt with
% correctly. 
% Alex Townsend, April 2013. 

if ( nargin < 1 ) 
    prefs = chebfunpref(); 
end 
tol = 100*prefs.cheb2Prefs.eps; 

error 

%%  Standard wave equation on a non-square domain. 

d = [-pi pi 0 1]; 
exact = chebfun2(@(x,t) sin(x+t), d); 
N = chebop2(@(u) diff(u,2,1) - diff(u,2,2), d);
N.lbc = @(t) sin(-pi+t);
N.rbc = @(t) sin(pi+t);
N.dbc = @(x,u) [u - sin(x) diff(u) - cos(x)];
u = N \ 0;
pass(1) = (abs( norm(u - exact)) < tol); 

%% Another standard example on a non-square domain. 

d = [-pi pi 0 1]; 
exact = chebfun2(@(x,t) sin(x+t) + sin(x-t), d); 
N = chebop2(@(u) diff(u,2,1) - diff(u,2,2), d);
N.lbc = @(t) sin(-pi+t) + sin(-pi -t);
N.rbc = @(t) sin(pi+t) + sin(pi -t);
N.dbc = @(x,u) [u - 2*sin(x) diff(u)];
u = N \ 0;
pass(2) = ( norm(u - exact) < tol); 

%% An example with a different wave speed. 

d = [-2*pi 2*pi 0 1]; c = 2; 
exact = chebfun2(@(x,t) sin(x+c*t) + sin(x-c*t), d); 
N = chebop2(@(u) diff(u,2,1) - c.^2*diff(u,2,2), d);
N.lbc = @(t) sin(-2*pi+c*t) + sin(-2*pi - c*t);
N.rbc = @(t) sin(2*pi+c*t) + sin(2*pi - c*t);
N.dbc = @(x,u) [u - 2*sin(x) diff(u)];
u = N \ 0;
pass(3) = ( norm(u - exact) < tol); 

%% Higher wave speed. 

d = [-2*pi 2*pi 0 1]; c = 30; 
exact = chebfun2(@(x,t) sin(x+c*t), d); 
N = chebop2(@(u) diff(u,2,1) - c^2*diff(u,2,2), d);
N.lbc = @(t) sin(-2*pi+c*t);
N.rbc = @(t) sin(2*pi+c*t);
N.dbc = @(x,u) [u - sin(x) diff(u) - c*cos(x)];
u = N \ 0;
[xx,yy] = meshgrid(linspace(d(1),d(2)),linspace(d(3),d(4)));
pass(4) = ( norm(u(xx,yy) - exact(xx,yy), inf) < 1e5*tol);

%% Working for non-zero starting time. 
d = [-2*pi 2*pi 1 2]; c = 3; 
exact = chebfun2(@(x,t) sin(x+c*t), d); 
N = chebop2(@(u) diff(u,2,1) - c^2*diff(u,2,2), d);
N.lbc = @(t) sin(-2*pi+c*t);
N.rbc = @(t) sin(2*pi+c*t);
N.dbc = @(x,u) [u - sin(c+x) diff(u) - c*cos(x+c)];
u = N \ 0;
pass(5) = ( norm(u - exact) < tol);

end