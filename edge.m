function img_canny = edge(img, sigma, treH, treL)
%%%%%%%%%
% Md. Facihul Azam 
% Id : 238949
% Canny edge detection function is carried out  by four steps 
% below shows four steps of edge detection.
%%%%%%%%%%%%
% thrL = 0;  % the best threshold
% thrH = 370; % the best threshold
  I_max = treH ;
  I_min = treL ;
  
theta1 = pi/2;
theta2 = 0;
threshold = 0.185;
input_img = imread(img);
% check the image if it is rgb or gray color image. If the image is rgb
% check image convert it to gray scale. gray imag keeps as it is
gray_img = check_image(input_img);

img_double = double(gray_img);
%%  step 1 %%%%%%%%%%
%%% convolution with 1st derivative gaussian filter. 
% horizontal direcion  
filterx = gaussian_dervative(sigma, theta1);
Ix= conv2(img_double,filterx,'same');
% vertical direction 
filtery = gaussian_dervative(sigma, theta2);
Iy=conv2(img_double,filtery,'same'); 

%% step 2 %%%%%%%%
% % Norm of the gradient (Combining the X and Y directional derivatives)

magn=sqrt(Ix.^2+Iy.^2);

%% Step3 %%%%%%%%%
% non maxima supression
[row,col] = size(magn); 
magn = [zeros(1,col); magn ; zeros(1,col)];
magn = [zeros(row+2,1) magn zeros(row+2,1)];
for i=2:row
       for j= 2:col
           if magn(i,j)< magn(i-1,j) || magn(i,j) <magn(i+1,j)
           IN(i,j) = 0; 
           else IN(i,j)= magn(i,j);
           end    
       end
 end    

%%  step 4 
% % Thresholding  and edge linking 
 magn= IN;
 
% I_max=max(max(magn)); 
% I_min=min(min(magn));
level=threshold*(I_max-I_min)+I_min;

I2= max(magn,level.*ones(size(magn))); % high threshold 
I1 = min(magn,level.*ones(size(magn)));  % low threshold 

Img_thershold = I2;

% interpolation to find the pixels where the gaps are found 
%
[n,m]=size(Img_thershold);
for i=2:n-1,
for j=2:m-1,
	if Img_thershold(i,j) > level,
	X=[-1,0,+1;-1,0,+1;-1,0,+1];  
	Y=[-1,-1,-1;0,0,0;+1,+1,+1];  
 	% 8x8 neighbourhood search coordinates
	Z=[Img_thershold(i-1,j-1),Img_thershold(i-1,j),Img_thershold(i-1,j+1);
	   Img_thershold(i,j-1),Img_thershold(i,j),Img_thershold(i,j+1);
	   Img_thershold(i+1,j-1),Img_thershold(i+1,j),Img_thershold(i+1,j+1)];
	IX_histeresis=[Ix(i,j)/magn(i,j), -Ix(i,j)/magn(i,j)];
	IY_histeresis=[Iy(i,j)/magn(i,j), -Iy(i,j)/magn(i,j)];
	I_interpolation=interp2(X,Y,Z,IX_histeresis,IY_histeresis);
		if Img_thershold(i,j) >= I_interpolation(1) && Img_thershold(i,j) >= I_interpolation(2)
		temp(i,j)=I_max;
		else
		temp(i,j)=I_min;
		end
	else
	temp(i,j)=I_min;
	end
end
end
img_canny = temp;





