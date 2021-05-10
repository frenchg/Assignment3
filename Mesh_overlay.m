% creating a rotation
r_x=pi*.5;
r_y=1.49*pi;
r_z=2.9*pi/2;
% r_x=pi*.5;
% r_y=1.49*pi;
% r_z=3*pi/2;
% r_x=2*pi/3;
% r_y=1.1*pi;
% r_z=-pi/2;
rotx = [1 0 0; 0 cos(r_x) -sin(r_x) ; 0 sin(r_x) cos(r_x)] ;
roty = [cos(r_y) 0 sin(r_y) ; 0 1 0 ; -sin(r_y) 0  cos(r_y)] ;
rotz = [cos(r_z) -sin(r_z) 0 ; sin(r_z) cos(r_z) 0 ; 0 0 1] ;


t_y  = [.3 0 900; 0 .3 1750; 0 0 1]; %%% creating a translation


%%% This is the code to create the mesh overlay on the picture 
size = length(Xo);
NewCol = ones(size,1);
%Xo = transpose(Xo);
New_Xo =  rotx*Xo;
New_Xo2 =  roty*New_Xo;
New_Xo3 = rotz*New_Xo2;
New_Xo3 = transpose(New_Xo3);

checker_k = [3572,0,1993;0,3563,1460;0,0,1]; % the checker matrix


x_tran = K*[R , T]*transpose([New_Xo3 NewCol]);
x_tran = transpose(x_tran);
x = [];

for i = 1:size
x(i,1) =  x_tran(i,1)/x_tran(i,3);
x(i,2) =  x_tran(i,2)/x_tran(i,3);
end

x_mesh = t_y*transpose([x NewCol]);

x_mesh = transpose(x_mesh);

lightdirectionvector=[0,0,1];

% figure;
% imshow(IMG_4021); hold on; % ‘hold on’ holds the image to draw more content
% patch('vertices', x_mesh', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'b');

%pointsInFront=isinfront(x_tran,Faces); % TAKES A LONG TIME TO RUN
imshow(IMG_4019); hold on;
displayLit(x_mesh,x_tran,Faces,lightdirectionvector,pointsInFront);

clear x_tran New_Xo x_mesh