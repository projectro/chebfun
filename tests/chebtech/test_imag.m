% Test file for chebtech/imag.

function pass = test_imag(pref)

if ( nargin < 1 )
    pref = chebtech.pref;
end

tol = 10*pref.chebtech.eps;

for ( n = 1:2 )
    if ( n == 1 )
        testclass = chebtech1();
    else 
        testclass = chebtech2();
    end

    % Test a scalar-valued function:
    f = testclass.make(@(x) cos(x) + 1i*sin(x), [], [], pref);
    g = testclass.make(@(x) sin(x), [], [], pref);
    h = imag(f);
    h = prolong(h, length(g));
    pass(n, 1) = norm(h.values - g.values, inf) < tol;
    
    % Test a multi-valued function:
    f = testclass.make(@(x) [cos(x) + 1i*sin(x), -exp(1i*x)], [], [], pref);
    g = testclass.make(@(x) [sin(x), -imag(exp(1i*x))], [], [], pref);
    h = imag(f);
    h = prolong(h, length(g));
    pass(n, 2) = norm(h.values - g.values, inf) < tol;
    
    % Test a real function:
    f = testclass.make(@(x) cos(x), [], [], pref);
    g = imag(f);
    pass(n, 3) = numel(g.values) == 1 && g.values == 0;
    
    % Test a multivalued real function:
    f = testclass.make(@(x) [cos(x), sin(x), exp(x)], [], [], pref);
    g = imag(f);
    pass(n, 4) = all(size(g.values) == [1, 3]) && all(g.values == 0);
end

end
