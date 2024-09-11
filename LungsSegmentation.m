function LungsSegmentation

close all

CTIMAGE=dicomread('C:\Users\windows 10\Desktop\vida 3\Lungs Visualization\data_1\CT000000','Frames','all');
NormalizedImage = double(CTIMAGE) / double(max(CTIMAGE(:)));
SCALEDIMAGE = uint8(255 * NormalizedImage);
frm=0;
timestep=1;  
mu=0.2;  
lambda=5; 
alfa= -3;  
epsilon=1.5; 
c0=2;
maxiter=1002;
sigma=2.0;    

G=fspecial('gaussian',30,sigma); 
Img_smooth=conv2(SCALEDIMAGE,G,'same');  
figure(1);
imagesc(Img_smooth,[0, 255]);
axis off; 
axis equal;
colormap(gray);
title('Smoothed image');

[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;
g=exp(-f);
figure(2);
imagesc(g); 
axis off;
axis equal; 
title('g,  edge indicator');

phi = c0*ones(size(SCALEDIMAGE));
phi(275:310,100:155)=-c0;
phi(275:310,400:455)=-c0;
figure(3);
imagesc(phi);
axis off; 
axis equal;
colormap(turbo);
title('initial phi matrix');
[vx, vy]=gradient(g);
figure(4);
subplot(1,2,1);imagesc(vx); title('x directioned gradient of g');
subplot(1,2,2);imagesc(vy); title('y directioned gradient of g');

for k=1:maxiter
    phi=NeumannBoundCond(phi);
    distRegTerm=distReg_p2(phi);
    diracPhi=Dirac(phi,epsilon);
    areaTerm=diracPhi.*g;
    [phi_x,phi_y]=gradient(phi);
    s=sqrt(phi_x.^2 + phi_y.^2);
    Nx=phi_x./(s+1e-10); 
    Ny=phi_y./(s+1e-10);
    edgeTerm=diracPhi.*(vx.*Nx+vy.*Ny) + diracPhi.*g.*div(Nx,Ny);
    phi=phi + timestep*(mu/timestep*distRegTerm + lambda*edgeTerm + alfa*areaTerm);
    if mod(k,50)==1
        frm=frm+1;
        h=figure(5);
        set(gcf,'color','w');
        subplot(1,2,1);
        II=SCALEDIMAGE;
        II(:,:,2)=SCALEDIMAGE;II(:,:,3)=SCALEDIMAGE;
        imshow(II); axis off; axis equal; hold on;  
        q=contour(phi, [0,0], 'r');
        msg=['contour result , iteration number=' num2str(k)];
        title(msg);
        subplot(1,2,2);
        mesh(-phi); 
        hold on;  contour(phi, [0,0], 'r','LineWidth',2);   
        view([180-30 65]);      
        msg=['phi result , iteration number=' num2str(k)];
        title(msg);
        pause(0.1)
        
        % Animation
        
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if frm == 1        
            imwrite(imind,cm,'Lung.gif','gif', 'Loopcount',inf);
        else        
            imwrite(imind,cm,'Lung.gif','gif','WriteMode','append');
        end
    end
    
end
figure(6);
imagesc(SCALEDIMAGE,[0, 255]);
axis off;
axis equal;
colormap(gray);
hold on;
contour(phi, [0,0], 'r');
msg=['phi result , iteration number=' num2str(k)];
title(msg);





