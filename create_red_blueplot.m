function[] = create_red_blueplot(imgpoints2D_estim,impoints)
imgpoints2D_estimated = zeros(12,2);
im1_points = impoints;
imgpoints2D_estim = transpose(imgpoints2D_estim);

for i =1:12
imgpoints2D_estimated(i,1) =  imgpoints2D_estim(i,1)/imgpoints2D_estim(i,3);
imgpoints2D_estimated(i,2) =  imgpoints2D_estim(i,2)/imgpoints2D_estim(i,3);
end

figure;
imshow(I); hold on;
plot( im1_points(:,1), im1_points(:,2), 'b.');
plot( imgpoints2D_estimated(:,1), imgpoints2D_estimated(:,2), 'r.');

end