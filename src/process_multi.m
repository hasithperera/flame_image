close all
clear all

data_dir = 'C:\Users\remote\Desktop\Susith_data\';
dark_frame = 'C:\Users\remote\Desktop\Susith_data\1.blank\blank _00023.jpg';



%% read the images-flame,blank.
folder = '-7.00 KV'
dark = im2double(imread(dark_frame));



%% get files

files = dir(strcat(data_dir,'/',folder,'/*.jpg')); 
%box format start end
box = [737 1361 353 1296];

low_thresh = .1;
high_thresh = .2;

%% loop for all images

fp = fopen(strcat('ahe_',folder,'.csv'),'a');

for i = 1:length(files)
    
    current_file = strcat(files(i).folder,'\',files(i).name);
    II = imread(current_file);
    
    
    im_current = im2double(imread(current_file));
    imgDiff = abs(im_current - dark);
    I = imgaussfilt(imgDiff,2);
    roi = I(box(3):box(4),box(1):box(2));

    
    %% process height
    sig = sum(roi');
    baseline = mean(sig(end-100:end));
    s1 = sig-baseline;
    [max_sig,max_indx] = max(s1);
    low_flame_lim = max_sig * low_thresh;
    max_flame_lim = max_sig * high_thresh;
    i_l = find_cross(s1,low_flame_lim,1);
    i_h = find_cross(s1,max_flame_lim,0);
    
    sig = sum(roi);
    baseline = mean(sig(end-100:end));
    s1 = sig-baseline;
    [max_sig,max_indx] = max(s1);
    low_flame_lim = max_sig * low_thresh;
    max_flame_lim = max_sig * high_thresh;
    i_l_w = find_cross(s1,low_flame_lim,1);
    i_h_w = find_cross(s1,max_flame_lim,0);
    fn_id = split(files(i).name,'_');
    
    fprintf(fp,'%s,%d,%d,%d,%d\n',fn_id{1},i_l,i_h,i_l_w,i_h_w);
    fprintf("%d - ok\n",i)
    
end
