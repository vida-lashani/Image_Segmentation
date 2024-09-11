function Y = div(nx,ny)
[nxx,junk]=gradient(nx);
[junk,nyy]=gradient(ny);
Y=nxx+nyy;