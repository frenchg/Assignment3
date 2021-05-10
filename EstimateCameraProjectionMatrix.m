function [M] = EstimateCameraProjectionMatrix( impoints,objpoints3D )
    im1_points = impoints;
    im2_points = objpoints3D;

    points_size = length(im1_points);

    v = 1:1:12;
    All_combinations = v  ; 

    count = 0;

    for i = 1:12  % creating a transform matrix
       count = 0;


       P(2*i-1,1) = -im2_points(All_combinations(i),1);
       P(2*i-1,2) = -im2_points(All_combinations(i),2);
       P(2*i-1,3) = -im2_points(All_combinations(i),3);
       P(2*i-1,4) = -1;
       P(2*i-1,5) = 0;
       P(2*i-1,6) = 0;
       P(2*i-1,7) = 0;
       P(2*i-1,8) = 0;
       P(2*i-1,9) = (im1_points(All_combinations(i),1)*im2_points(All_combinations(i),1));
       P(2*i-1,10) = (im1_points(All_combinations(i),1)*im2_points(All_combinations(i),2));
       P(2*i-1,11) = (im1_points(All_combinations(i),1)*im2_points(All_combinations(i),3));
       P(2*i-1,12) = im1_points(All_combinations(i),1);


       P(2*i,1) = 0;
       P(2*i,2) = 0;
       P(2*i,3) = 0;
       P(2*i,4) = 0;
       P(2*i,5) = -im2_points(All_combinations(i),1);
       P(2*i,6) = -im2_points(All_combinations(i),2);
       P(2*i,7) = -im2_points(All_combinations(i),3);
       P(2*i,8) = -1;
       P(2*i,9) = (im1_points(All_combinations(i),2)*im2_points(All_combinations(i),1));
       P(2*i,10) = (im1_points(All_combinations(i),2)*im2_points(All_combinations(i),2));
       P(2*i,11) = (im1_points(All_combinations(i),2)*im2_points(All_combinations(i),3));
       P(2*i,12) = im1_points(All_combinations(i),2);
    end
      [U,S,V] = svd(P,'econ');

       V_T = transpose(V);

       C = (V_T(12,:));

       M = transpose(reshape(C,4,3));% finding the transfrom from SVD

   for k = 1:points_size % testing transform matrix on all points 

     corcheck = M*[im2_points(k,1);im2_points(k,2);im2_points(k,3);1];
     X_prime = corcheck(1)/corcheck(3);
     Y_prime = corcheck(2)/corcheck(3);


     x_dif = (im1_points(k,1)- X_prime);
     y_dif =(im1_points(k,2)- Y_prime); %finding the distance in x and y

     e = sqrt(x_dif^2+y_dif^2);
        if e<200 % checking how good each transfrom for x y to x' y' is; although this isn't needed I still run it
                 % to make sure its a good transfrom for all twelve points
            count = count+1;

        end
   end
end




