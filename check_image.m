function gray_img = check_image(image)
img  = size(image);
if length(img)== 3
   gray_img = rgb2gray(image);
else gray_img = image; 
    
end

