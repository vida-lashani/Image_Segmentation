function Y = NeumannBoundCond(X)
[nrow,ncol] = size(X);
Y = X;
Y([1 nrow],[1 ncol]) = Y([3 nrow-2],[3 ncol-2]);
Y([1 nrow],2:end-1) = Y([3 nrow-2],2:end-1);
Y(2:end-1,[1 ncol]) = Y(2:end-1,[3 ncol-2]);