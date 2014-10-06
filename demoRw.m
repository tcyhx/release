%Semi-automatic 2d-to-3d conversion using random walks
%04/27/14 - Hongxing Yuan
%
%The code  has been tested in MATLAB R2013a running on Windows 7(64bit). 
%- Note:
%(1) If you plan to use this software or any variant of it, please, refer the following paper:
%    Yuan H, Wu S, Cheng P, An P, and Bao S, Nonlocal Random Walks for Semi-Automatic 2D-to-3D Image Conversion, 
%    IEEE Signal Processing Letters, 2015, 22(3): 371-374.
%(2) For any questions, suggestions or bug reports, please, contact yuanhx@mail.ustc.edu.cn

clear
close all
addpath('algorithm');

dirname  = 'imgs/girl';
filename = 'girl';
savename = 'depth_rw';
betaC    = 60;                                                 %The free paremeter controling how color dissimilarity

%Read image
img   = imread(sprintf('%s/%s.png',dirname,filename));         %read 2D color image
lbls  = double(imread(sprintf('%s/strokes.png',dirname)))/255; %read user labels and normalize them to [0,1]
mask  = imread(sprintf('%s/mask.png',dirname));                %read user mask
mask  = im2bw(mask,0);
seeds = find(mask==1);                                         %get seeded pixels
%main routine
prob  = rwCore(img, seeds, lbls, betaC);                       %estimate probability of each pixel which has the depth value of 255
depth = uint8(prob.*255);                                      %mapping probabilites to depth values
imshow(depth);
imwrite(depth,sprintf('%s/%s.png',dirname,savename));          %save results
