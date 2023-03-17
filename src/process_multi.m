close all
clear all

data_dir = 'C:\RESEARCH\.1.1OH images\Susith- retake data accurate(3.12.2022)\OH height and width\5.00 mm (31 MM)';
dark_frame = 'C:\RESEARCH\.1.1OH images\Susith - new ring,nozzle 4.2 mm\1.blank\blank _00012.jpg';



%% read the images-flame,blank.
folder = '-6.25 KV'
dark = imread(dark_frame);



%% get files

files = dir(strcat(data_dir,'/',folder,'/*.jpg')); 
%box format start end
box = [737 1361 353 1296];

low_thresh = .1;
high_thresh = .1;

%% loop for all images

fp = fopen(strcat('_',folder,'.csv'),'a');

for i = 1:length(files)
    
    current_file = strcat(files(i).folder,'\',files(i).name);
%     II = imread(current_file);
    
    disp(files(i).name)
    im_current = imread(current_file);
    imgDiff = abs(im_current - dark);
    I = imgaussfilt(imgDiff,7);
    roi = I(box(3):box(4),box(1):box(2));

    
    %% process height
    sig = sum(roi');
    baseline = mean(sig(end-100:end));
    s1 = sig-baseline;
    [max_sig,max_indx] = max(s1);
    disp(max_sig)
    low_flame_lim = max_sig * low_thresh;
    max_flame_lim = max_sig * high_thresh;
    
    disp(low_flame_lim)
    i_l = find_cross(s1,low_flame_lim,1);
    
    i_h = find_cross(s1,max_flame_lim,0,1);
    
    sig = sum(roi);
    baseline = mean(sig(end-100:end));
    s1 = sig-baseline;
    [max_sig,max_indx] = max(s1);
    low_flame_lim = max_sig * low_thresh;
    max_flame_lim = max_sig * high_thresh;
    i_l_w = find_cross(s1,low_flame_lim,0);
    i_h_w = find_cross(s1,max_flame_lim,0);
    fn_id = split(files(i).name,'_');
    
    fprintf(fp,'%s,%d,%d,%d,%d\n',fn_id{1},i_l,i_h,i_l_w,i_h_w);
    fprintf(2,'%s,%d,%d,%d,%d\n',fn_id{1},i_l,i_h,i_l_w,i_h_w);
    fprintf("%d - ok\n",i)
    
end
fclose(fp)