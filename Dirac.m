function Y = Dirac(X, S)
Y=(1/2/S)*(1+cos(pi*X/S));
b = (X<=S) & (X>=-S);
Y = Y.*b;