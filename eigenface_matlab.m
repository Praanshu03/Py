mydir = '/Users/Praanshu/Documents/MATLAB/FaceRecognition_Data/ALL';
folder = dir(fullfile(mydir,'*.TIF'));
M_length = length(folder);
X = [];

% Reading all images and vectorizing in a 1024 X 35 vector

for i= 1:M_length
    img = imread(fullfile(mydir,folder(i).name));
    img_flat = double (img(:));
    X = [X img_flat];

end

% Calculating mean of each row

mean_vector = mean(X')';  

% Displaying the average image
Avg_img= reshape(mean_vector,[32,32]);


figure();
imagesc(Avg_img), title('Average Image');

% Calculating difference from mean for the training set
rep_mean_vector = repmat(mean_vector,[1,35]);

A = X - rep_mean_vector;

%Covariance matrix
%principal components are the top K eigenvectors of covariance matrix
%principal lengths are the eigenvalues of covariance matrix

C = A * A';

[v,d] = eig(C);

%Sorting eigenvectors in decreasing order of eigenvals

eig_val = diag(d);
[sorted_eig_val, idx] = sort(eig_val, 'descend');
eig_vector = v(:,idx);
final_eig_vector =  eig_vector(:,1:100);

%Constructing DB

mydir = '/Users/Praanshu/Documents/MATLAB/FaceRecognition_Data/FA';
folder2 = dir(fullfile(mydir,'*.TIF'));
DB_length = length(folder2);
DB_test = [];

for i= 1:DB_length
img_db = imread(fullfile(mydir,folder2(i).name));
img_db_flat = double (img_db(:));
DB_test = [DB_test img_db_flat];
end

y = (DB_test) - rep_mean_vector(:,1:DB_length);
eigenfaces = final_eig_vector' * y;
    
% Nearest neighbour

mydir = '/Users/Praanshu/Documents/MATLAB/FaceRecognition_Data/FB';
folder3 = dir(fullfile(mydir,'*.TIF'));
Test_length = length(folder3);
FB_test = [];

for i= 1:Test_length
img_test = imread(fullfile(mydir,folder3(i).name));
img_test_flat = double (img_test(:));
FB_test = [FB_test img_test_flat];
end


yz = (FB_test) - rep_mean_vector(:,1:Test_length);
fb_yz = final_eig_vector' * yz;


% Loop through test images (23)

min_dist_idx = [];
for i = 1:Test_length;
    
    euclidean_dist_array = [];
    
    % For each image, calculate Euclidean dist with 12 train images
    for j = 1:DB_length;
        euclidean_dist = sqrt(sum((fb_yz(:, i) - eigenfaces(:, j)) .^ 2)); 
        euclidean_dist_array = [euclidean_dist_array euclidean_dist];
        
    end;
    
        % Find the min distance
        min_euclidean_dist = min(euclidean_dist_array);
        
        % Get index of the min-distance image
        min_dist_idx = [min_dist_idx find(euclidean_dist_array == min_euclidean_dist)];
end;

min_dist_idx = min_dist_idx(:);

flag = 0;

for i = 1:Test_length
    % Checking for accuracy of the algorithm
    
     if folder3(i).name(7:11) == folder2(min_dist_idx(i)).name(7:11)
        flag = flag + 1;
     
     end
     
    % Displaying test images with predicted images to see the output
    
    Test_img= reshape(FB_test(:,i), [32,32]);
    
    subplot(8,6,i*2-1),imagesc(Test_img,'XData',[1 592], 'YData',[1 481]), title('test')

    Pred_img= reshape(DB_test(:,min_dist_idx(i)), [32,32]);
    
    subplot(8,6,i*2), imagesc(Pred_img,'XData',[1 592], 'YData',[1 481]), title('pred')


end
 
%Printing accuracy

Accuracy = (flag/Test_length) * 100;
check = ["Eigenface Accuracy :", num2str(Accuracy)];
disp (check)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%To complete the eigenface algorithm, I referenced the article
%on'EigenFaces For Recognition' by Matthew Turk and Alex Pentland.





