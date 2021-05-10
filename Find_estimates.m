
function[imgpoints2D_estim] = Find_estimates(M, im2_points)
A = M(:,1:3);
B = M(:,4:4);

C = A*transpose(A);
    
lambda = sqrt(1/C(3,3)); % may be pos or neg
X_c = lambda^2*C(1,3);
Y_c = lambda^2*C(2,3);
F_y = sqrt(lambda^2*C(2,2)-Y_c^2);
Alpha = (1/F_y)*(lambda^2*C(1,2)-X_c*Y_c);
F_x = sqrt(lambda^2*C(1,1)-Alpha^2-X_c^2);

K = [F_x,Alpha,X_c;0,F_y,Y_c;0,0,1];

R_plus = inv(K)*lambda*A;
R_minus = inv(K)*(-lambda)*A;

if round(det(R_plus)) ==1
    R = R_plus;
end
if round(det(R_minus)) == 1
    R = R_plus;
    lambda = -lambda;
end

T = lambda*inv(K)*B;

NewCol = ones(12,1);

imgpoints2D_estim = K*[R , T]*transpose([im2_points NewCol]);

end